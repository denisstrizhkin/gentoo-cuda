FROM gentoo/stage3

RUN emerge-webrsync \
  && rmdir /etc/portage/{package.use,package.accept_keywords} \
  && sed -i 's/^COMMON_FLAGS.*/COMMON_FLAGS="-O2 -march=native -pipe"/' /etc/portage/make.conf \
  && echo 'FEATURES="-ipc-sandbox -network-sandbox -pid-sandbox"' >> /etc/portage/make.conf \
  && eselect profile set default/linux/amd64/17.1/no-multilib \
  && emerge app-portage/cpuid2cpuflags \
  && echo "*/* $(cpuid2cpuflags)" > /etc/portage/package.use \
  && emerge -DNu --backtrack=100 @world \
  && echo 'x11-drivers/nvidia-drivers -X -modules -tools' >> /etc/portage/package.use \
  && echo -e 'x11-drivers/nvidia-drivers NVIDIA-r2\ndev-util/nvidia-cuda-toolkit NVIDIA-CUDA' > /etc/portage/package.license \
  && echo 'dev-util/nvidia-cuda-toolkit' > /etc/portage/package.accept_keywords \
  && emerge dev-util/nvidia-cuda-toolkit \
  && emerge -c \
  && rm -rf /var/cache/distfiles/* \
  && rm -rf /var/db/repos/*

CMD [ "/bin/bash", "--login" ]
ENTRYPOINT [ "/bin/bash", "--login", "-c" ]
