FROM gentoominimal as builder

RUN  emerge -q gcc:12 \
  && emerge -C gcc:13

RUN  rmdir /etc/portage/package.mask \
  && echo 'sys-devel/gcc:13' > /etc/portage/package.mask

RUN emerge -eq @world

RUN  echo 'x11-drivers/nvidia-drivers -X -modules -tools' >> /etc/portage/package.use \
  && echo 'x11-drivers/nvidia-drivers NVIDIA-r2'     >  /etc/portage/package.license \
  && echo 'dev-util/nvidia-cuda-toolkit NVIDIA-CUDA' >> /etc/portage/package.license \
  && echo 'dev-util/nvidia-cuda-toolkit' > /etc/portage/package.accept_keywords \
  && echo 'x11-drivers/nvidia-drivers:0/535' >> /etc/portage/package.mask

RUN  emerge -q dev-util/nvidia-cuda-toolkit \
  && emerge -c \
  && rm -rf /var/cache/distfiles/*

FROM scratch

WORKDIR /
COPY --from=builder / /

CMD [ "/bin/bash", "--login" ]
ENTRYPOINT [ "/bin/bash", "--login", "-c" ]
