FROM gentoo/stage3

RUN emerge-webrsync

RUN rmdir /etc/portage/{package.use,package.accept_keywords}

RUN emerge -1 sys-devel/llvm

RUN echo 'media-libs/libglvnd X' > /etc/portage/package.use
RUN emerge -1 media-libs/mesa

RUN echo -e 'x11-drivers/nvidia-drivers -modules\n\
x11-libs/cairo X' >> /etc/portage/package.use
RUN echo 'x11-drivers/nvidia-drivers NVIDIA-r2' > /etc/portage/package.license
RUN emerge -1 x11-drivers/nvidia-drivers

RUN echo 'dev-util/nvidia-cuda-toolkit NVIDIA-CUDA' >> /etc/portage/package.license
RUN echo 'dev-util/nvidia-cuda-toolkit' > /etc/portage/package.accept_keywords
RUN emerge dev-util/nvidia-cuda-toolkit