FROM gentoominimal as builder

RUN emerge-webrsync \
  && echo 'x11-drivers/nvidia-drivers -X -modules -tools' >> /etc/portage/package.use \
  && echo 'x11-drivers/nvidia-drivers NVIDIA-r2'     >  /etc/portage/package.license \
  && echo 'dev-util/nvidia-cuda-toolkit NVIDIA-CUDA' >> /etc/portage/package.license \
  && echo 'dev-util/nvidia-cuda-toolkit' > /etc/portage/package.accept_keywords \
  && emerge -q dev-util/nvidia-cuda-toolkit \
  && emerge -c \
  && rm -rf /var/cache/distfiles/* \
  && rm -rf /var/db/repos/*

FROM scratch

WORKDIR /
COPY --from=builder / /
