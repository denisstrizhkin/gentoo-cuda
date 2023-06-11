FROM gentoo/stage3

RUN emerge-webrsync \
  && rmdir /etc/portage/{package.use,package.accept_keywords} \
  && echo 'x11-drivers/nvidia-drivers -X -modules -tools' > /etc/portage/package.use \
  && echo -e 'x11-drivers/nvidia-drivers NVIDIA-r2\ndev-util/nvidia-cuda-toolkit NVIDIA-CUDA' > /etc/portage/package.license \
  && echo 'dev-util/nvidia-cuda-toolkit' > /etc/portage/package.accept_keywords \
  && emerge dev-util/nvidia-cuda-toolkit \
  && rm -rf /var/cache/distfiles/* \
  && rm -rf /var/db/repos/*

CMD [ "/bin/bash", "--login" ]
ENTRYPOINT [ "/bin/bash", "--login", "-c" ]