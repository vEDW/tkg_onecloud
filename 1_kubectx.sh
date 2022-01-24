# source define_download_version_env
source define_download_version_env

#checking and creating BITSDIR if needed
if [[ ! -e $BITSDIR ]]; then
    mkdir $BITSDIR
fi

COMPLETIONS=/etc/bash_completion.d

git clone https://github.com/ahmetb/kubectx \
&& cd kubectx \
&& sudo mv kubectx /usr/local/bin/kctx \
&& sudo mv kubens /usr/local/bin/kns \
&& sudo mv completion/*.bash $COMPLETIONS \
&& cd .. \
&& rm -rf kubectx
