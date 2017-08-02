node bos {
  include user
  include ssh
  include fail2ban
}

Crons
   if ENV["DEPLOY_STAGE"] == "staging_cdr"
      #cron 'load_boms_from_db', command: "/srv/staging_cdr/current/script/load_boms_from_db >> /home/deploy/cron/load_boms_from_db.log", user: "deploy", minute: "*/15"
      #cron 'partner_invitations', command: '/srv/staging_cdr/current/script/partner_invitations > "/home/deploy/cron/partner_invitations.log"', user: "deploy", minute: "*/15"
      #cron 'rsl_shares', command: '/srv/staging_cdr/current/script/get_shared_rsls > "/home/deploy/cron/shared_rsls.log"', user: "deploy", minute: "*/15"

    elsif ENV["DEPLOY_STAGE"] == "cdr"
      cron 'load_boms_from_db', command: "/srv/cdr/current/script/load_boms_from_db >> /home/deploy/cron/load_boms_from_db.log", user: "deploy", minute: "15"
      cron 'partner_invitations', command: '/srv/cdr/current/script/partner_invitations > "/home/deploy/cron/partner_invitations.log"', user: "deploy", minute: "*/15"

      # user guides
      cron 'lens_user_guide_others', command: '/srv/cdr/current/script/lens_user_guide_others >> /home/deploy/cron/lens_user_guide_others.log', user: "deploy", hour: 5, minute: 35
      cron 'lens_user_guide_toy', command: '/srv/cdr/current/script/lens_user_guide_toy >> /home/deploy/cron/lens_user_guide_toy.log', user: "deploy", hour: 5, minute: 40
      cron 'lens_user_guide_auto', command: '/srv/cdr/current/script/lens_user_guide_auto >> /home/deploy/cron/lens_user_guide_auto.log', user: "deploy", hour: 5, minute: 45
      cron 'lens_user_guide_packaging', command: '/srv/cdr/current/script/lens_user_guide_packaging >> /home/deploy/cron/lens_user_guide_packaging.log', user: "deploy", hour: 5, minute: 50
      cron 'ssp_user_guide', command: '/srv/cdr/current/script/ssp_user_guide >> /home/deploy/cron/ssp_user_guide.log', user: "deploy", hour: 3, minute: 33
