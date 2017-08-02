node nightly {
  include user
  include ssh
  include fail2ban
}
class crons {
  cron {'cdr_to_lens': 
    command => '/srv/staging_cdr/current/script/cdr_to_lens > "/home/deploy/cron/cdr_to_lens_`date +\%Y-\%m-\%d`.log" 2>&1', 
    user => "deploy",
    hour => 3,
    minute => 03,
    }
  cron { 'push_sv_rsls':
    command => '/srv/staging_cdr/current/script/push_sv_rsls >> "/home/deploy/cron/push_sv_rsls.log"',
    user => "deploy",
    minute => "*/5", 
    }
  cron { 'workoff_delayed_jobs':
    command => '/srv/staging_cdr/current/script/workoff_delayed_jobs >> "/home/deploy/cron/workoff_delayed_jobs.log"',
    user => "deploy",
    minute => "*/5",
    }