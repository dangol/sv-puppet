#!/usr/bin/env rspec

require 'spec_helper'

FileTest.stubs(:exist?).returns false
FileTest.stubs(:exist?).with('/etc/syslog.conf').returns true
provider_class = Puppet::Type.type(:syslog).provider(:augeas)

describe provider_class do
  before :each do
    FileTest.stubs(:exist?).returns false
    FileTest.stubs(:exist?).with('/etc/syslog.conf').returns true
  end

  let(:protocol_supported) { subject.protocol_supported }

  context "with empty file" do
    let(:tmptarget) { aug_fixture("empty") }
    let(:target) { tmptarget.path }

    it "should create simple new entry" do
      apply!(Puppet::Type.type(:syslog).new(
        :name        => "my test",
        :facility    => "local2",
        :level       => "*",
        :action_type => "file",
        :action      => "/var/log/test.log",
        :target      => target,
        :provider    => "augeas",
        :ensure      => "present"
      ))

      aug_open(target, "Syslog.lns") do |aug|
        expect(aug.match("entry").size).to eq(1)
        expect(aug.get("entry/action/file")).to eq("/var/log/test.log")
        expect(aug.match("entry/action/no_sync").size).to eq(0)
      end
    end

    it "should create hostname entry with tcp protocol" do
      if protocol_supported
        apply!(Puppet::Type.type(:syslog).new(
          :name            => "hostname test",
          :facility        => "*",
          :level           => "*",
          :action_type     => "hostname",
          :action_protocol => "tcp",
          :action          => "remote-host",
          :target          => target,
          :provider        => "augeas",
          :ensure          => "present"
        ))

        aug_open(target, "Syslog.lns") do |aug|
          expect(aug.match("entry").size).to eq(1)
          expect(aug.get("entry/action/protocol")).to eq("@@")
          expect(aug.match("entry/action/port").size).to eq(0)
        end
      else
        txn = apply(Puppet::Type.type(:syslog).new(
          :name            => "hostname test",
          :facility        => "*",
          :level           => "*",
          :action_type     => "hostname",
          :action_protocol => "tcp",
          :action          => "remote-host",
          :target          => target,
          :provider        => "augeas",
          :ensure          => "present"
        ))
        expect(txn.any_failed?).not_to eq(nil)
        expect(@logs[0].level).to eq(:err)
        expect(@logs[0].message.include?('Protocol is not supported')).to eq(true)
      end
    end

    it "should create hostname entry with udp protocol" do
      if protocol_supported == :stock
        apply!(Puppet::Type.type(:syslog).new(
          :name            => "hostname test",
          :facility        => "*",
          :level           => "*",
          :action_type     => "hostname",
          :action_protocol => "udp",
          :action          => "remote-host",
          :target          => target,
          :provider        => "augeas",
          :ensure          => "present"
        ))

        aug_open(target, "Syslog.lns") do |aug|
          expect(aug.match("entry").size).to eq(1)
          expect(aug.get("entry/action/protocol")).to eq("@")
          expect(aug.match("entry/action/port").size).to eq(0)
        end
      elsif protocol_supported == :el7
        apply!(Puppet::Type.type(:syslog).new(
          :name            => "hostname test",
          :facility        => "*",
          :level           => "*",
          :action_type     => "hostname",
          :action_protocol => "udp",
          :action          => "remote-host",
          :target          => target,
          :provider        => "augeas",
          :ensure          => "present"
        ))

        aug_open(target, "Syslog.lns") do |aug|
          expect(aug.match("entry").size).to eq(1)
          expect(aug.match("entry/action/protocol").size).to eq(0)
          expect(aug.match("entry/action/port").size).to eq(0)
        end
      else
        txn = apply(Puppet::Type.type(:syslog).new(
          :name            => "hostname test",
          :facility        => "*",
          :level           => "*",
          :action_type     => "hostname",
          :action_protocol => "udp",
          :action          => "remote-host",
          :target          => target,
          :provider        => "augeas",
          :ensure          => "present"
        ))
        expect(txn.any_failed?).not_to eq(nil)
        expect(@logs[0].level).to eq(:err)
        expect(@logs[0].message.include?('Protocol is not supported')).to eq(true)
      end
    end

    it "should create hostname entry with port" do
      if protocol_supported  # port requires protocol
        apply!(Puppet::Type.type(:syslog).new(
          :name            => "hostname test",
          :facility        => "*",
          :level           => "*",
          :action_type     => "hostname",
          :action_port     => "514",
          :action_protocol => "tcp",
          :action          => "remote-host",
          :target          => target,
          :provider        => "augeas",
          :ensure          => "present"
        ))

        aug_open(target, "Syslog.lns") do |aug|
          expect(aug.match("entry").size).to eq(1)
          expect(aug.get("entry/action/protocol")).to eq("@@")
          expect(aug.get("entry/action/port")).to eq("514")
        end
      else
        txn = apply(Puppet::Type.type(:syslog).new(
          :name            => "hostname test",
          :facility        => "*",
          :level           => "*",
          :action_type     => "hostname",
          :action_port     => "514",
          :action_protocol => "tcp",
          :action          => "remote-host",
          :target          => target,
          :provider        => "augeas",
          :ensure          => "present"
        ))
        expect(txn.any_failed?).not_to eq(nil)
        expect(@logs[0].level).to eq(:err)
        expect(@logs[0].message.include?('Protocol is not supported')).to eq(true)
      end
    end
  end

  context "with full file" do
    let(:tmptarget) { aug_fixture("full") }
    let(:target) { tmptarget.path }

    it "should list instances" do
      provider_class.stubs(:target).returns(target)
      inst = provider_class.instances.map { |p|
        {
          :name => p.get(:name),
          :ensure => p.get(:ensure),
          :facility => p.get(:facility),
          :level => p.get(:level),
          :no_sync => p.get(:no_sync),
          :action_type => p.get(:action_type),
          :action_port => p.get(:action_port),
          :action_protocol => p.get(:action_protocol),
          :action => p.get(:action),
        }
      }

      expect(inst.size).to eq(10)
      expect(inst[0]).to eq({:name=>"*.info /var/log/messages", :ensure=>:present, :facility=>"*", :level=>"info", :no_sync=>:false, :action_type=>"file", :action=>"/var/log/messages", :action_port=>:absent, :action_protocol=>:absent})
      expect(inst[1]).to eq({:name=>"mail.none /var/log/messages", :ensure=>:present, :facility=>"mail", :level=>"none", :no_sync=>:false, :action_type=>"file", :action=>"/var/log/messages", :action_port=>:absent, :action_protocol=>:absent})
      expect(inst[5]).to eq({:name=>"mail.* -/var/log/maillog", :ensure=>:present, :facility=>"mail", :level=>"*", :no_sync=>:true, :action_type=>"file", :action=>"/var/log/maillog", :action_port=>:absent, :action_protocol=>:absent})
      expect(inst[8]).to eq({:name=>"uucp.crit /var/log/spooler", :ensure=>:present, :facility=>"uucp", :level=>"crit", :no_sync=>:false, :action_type=>"file", :action=>"/var/log/spooler", :action_port=>:absent, :action_protocol=>:absent})
      expect(inst[9]).to eq({:name=>"news.crit /var/log/spooler", :ensure=>:present, :facility=>"news", :level=>"crit", :no_sync=>:false, :action_type=>"file", :action=>"/var/log/spooler", :action_port=>:absent, :action_protocol=>:absent})
    end

    describe "when creating settings" do
      it "should create a simple new entry" do
        apply!(Puppet::Type.type(:syslog).new(
          :name        => "my test",
          :facility    => "local2",
          :level       => "info",
          :action_type => "file",
          :action      => "/var/log/test.log",
          :target      => target,
          :provider    => "augeas",
          :ensure      => "present"
        ))

        aug_open(target, "Syslog.lns") do |aug|
          expect(aug.get("entry[selector/facility='local2']/action/file")).to eq("/var/log/test.log")
          expect(aug.match("entry[selector/facility='local2']/action/no_sync").size).to eq(0)
        end
      end
    end

    describe "when modifying settings" do
      it "should add a no_sync flag" do
        apply!(Puppet::Type.type(:syslog).new(
          :name        => "cron.*",
          :facility    => "cron",
          :level       => "*",
          :action_type => "file",
          :action      => "/var/log/cron",
          :target      => target,
          :no_sync     => :true,
          :provider    => "augeas",
          :ensure      => "present"
        ))

        aug_open(target, "Syslog.lns") do |aug|
          expect(aug.match("entry[selector/facility='cron']/action/no_sync").size).to eq(1)
        end
      end

      it "should remove the no_sync flag" do
        apply!(Puppet::Type.type(:syslog).new(
          :name        => "mail.*",
          :facility    => "mail",
          :level       => "*",
          :action_type => "file",
          :action      => "/var/log/maillog",
          :target      => target,
          :no_sync     => :false,
          :provider    => "augeas",
          :ensure      => "present"
        ))

        aug_open(target, "Syslog.lns") do |aug|
          expect(aug.match("entry[selector/facility='mail']/action/no_sync").size).to eq(0)
        end
      end
    end

    describe "when removing settings" do
      it "should remove the entry" do
        apply!(Puppet::Type.type(:syslog).new(
          :name        => "mail.*",
          :facility    => "mail",
          :level       => "*",
          :action_type => "file",
          :action      => "/var/log/maillog",
          :target      => target,
          :provider    => "augeas",
          :ensure      => "absent"
        ))

        aug_open(target, "Syslog.lns") do |aug|
          expect(aug.match("entry[selector/facility='mail' and level='*']").size).to eq(0)
        end
      end
    end
  end

  context "with broken file" do
    let(:tmptarget) { aug_fixture("broken") }
    let(:target) { tmptarget.path }

    it "should fail to load" do
      txn = apply(Puppet::Type.type(:syslog).new(
        :name        => "mail.*",
        :facility    => "mail",
        :level       => "*",
        :action_type => "file",
        :action      => "/var/log/maillog",
        :target      => target,
        :provider    => "augeas",
        :ensure      => "present"
      ))

      expect(txn.any_failed?).not_to eq(nil)
      expect(@logs.first.level).to eq(:err)
      expect(@logs.first.message.include?(target)).to eq(true)
    end
  end
end
