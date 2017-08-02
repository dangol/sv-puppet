node bos {
  include user
  include ssh
  include fail2ban
}
#staging_bos
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

# prod_bos
  cron { 'partner_invitations':
    command => '/srv/cdr/current/script/partner_invitations > "/home/deploy/cron/partner_invitations.log" 2>&1',
    user => "deploy",
    minute => "*/15",
    }
  cron { 'load_boms_from_db':
    command => '/srv/cdr/current/script/load_boms_from_db >> /home/deploy/cron/load_boms_from_db.log 2>&1',
    user => "deploy",
    minute => "15",
    }
  cron { 'lens_user_guide_others':
    command => '/srv/cdr/current/script/lens_user_guide_others >> /home/deploy/cron/lens_user_guide_others.log 2>&1',
    user => "deploy",
    hour => "5",
    minute => "35",
    }
  cron { 'lens_user_guide_toy':
    command => '/srv/cdr/current/script/lens_user_guide_toy >> /home/deploy/cron/lens_user_guide_toy.log 2>&1',
    user => "deploy",
    hour => "5",
    minute => "40",
    }
  cron { 'lens_user_guide_auto';
    command => '/srv/cdr/current/script/lens_user_guide_auto >> /home/deploy/cron/lens_user_guide_auto.log 2>&1',
    user => "deploy",
    hour => "5",
    minute => "45",
    }
  cron { 'lens_user_guide_packaging':
     command => '/srv/cdr/current/script/lens_user_guide_packaging >> /home/deploy/cron/lens_user_guide_packaging.log 2>&1',
     user = "deploy",
     hour => "5",
     minute => "50",
     }
  cron { 'ssp_user_guide':
     command => '/srv/cdr/current/script/ssp_user_guide >> /home/deploy/cron/ssp_user_guide.log 2>&1',
     user = "deploy",
     hour = 3,
     minute = 33,
     }
