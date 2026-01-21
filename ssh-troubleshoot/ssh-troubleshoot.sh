#if anyday ssh fails from google cloud shell
#1  os login disable
gcloud compute instances add-metadata mc-server \
  --zone us-central1-a \
  --metadata block-project-ssh-keys=FALSE
#2 remove old keys
rm -f ~/.ssh/google_compute_engine*
#3 regen key
gcloud compute ssh mc-server \
  --zone us-central1-a \
  --force-key-file-overwrite

