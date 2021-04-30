#cloud-config
users:
  - name: root
    ssh_authorized_keys:
      - 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCyPMbkmFLNA9wEOd4rFBnEDivaycPDWrCSUpyyCpk/6Rcuht4kfqdnuZpryUHtWW0RtJn5gu65gtyjY5VtEXk5jvnsasjnLnD/Hgev/9VAWP5muGehoReG6AbnVGT5Mt2uqmHZJShkHKycOxRRPc+CRaSBrixSKj+jYAiPs1kEOvG+KEq+rGVr/VbyoW5E/f1i1Zxnl6E5/y+E9ccvOGLO4UAtNxUYDotuRTC1gD7n84JvgTUg/yt23k9C2zcvLEK4K5fkosLse9z1H2Nro+SKD14ZZXlNqf19qSGZBpdMlQU7jlMQx6G9aFqfJlp+AjjxnGp3O1R9wC5tPGYBPGGsbIzYR553PSIG+heY0jX8pBxL2R50lZbPAcNryxSGZcPb+h7CtZO9ka3eBhq3AFVG6aHyIi7eGMG8pt5XzZ7WSN+IopAWuJsm5Uwk2EFU+YUi15Ng5T12OBN6gp69ZJPJIjWU/zW9Q9lyPtvJgE/ZCuJekdWmeLPhhJp3R3u8zfilMW6Prz4bgjnACCOBx9DS/xgAUGPXfH67r6Esa2YhABFSFN9oqvlycnHktqtAW7LXxlxetfYLxMRDsuW6nRjJxOTsYaCcSrJt9xpocMSF0AHH/+jaJNbjjvCcBQf4t6M1bH+nFhALO1kCUQT/nnu/UG4W/scOu9GIAvZaq/K+gw== dymaczew@Wlodeks-MBP'
    lock_passwd: true

final_message: "The system is finally up, after $UPTIME seconds"

