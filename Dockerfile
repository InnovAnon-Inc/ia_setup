FROM python AS base
ENV DEBIAN_FRONTEND noninteractive

RUN apt update                   \
&&  apt full-upgrade -y          \
&& rm -rf  /var/lib/apt/lists/*

RUN pip install --no-cache-dir --upgrade pysocks
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir --upgrade setuptools wheel Cython

FROM base AS ia_setup
RUN pip install --no-cache-dir --upgrade ia_setup
ENTRYPOINT ["python", "-m", "ia_setup"]
