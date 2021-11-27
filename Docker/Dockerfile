FROM continuumio/anaconda3:2019.03

# shap用にg++とgccをインストールします
RUN apt-get update
RUN apt-get install -y --no-install-recommends g++ gcc libgl1-mesa-dev make

WORKDIR /tmp
RUN wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz
RUN tar zxvf ta-lib* && cd ta-lib* && ./configure --prefix=/usr && make && make install

# 必要なライブラリをインストールします
RUN pip install --upgrade pip
RUN pip install shap==0.37.0 \
                slicer==0.0.3 \
                xgboost==1.3.0.post0 \
                opencv-contrib-python \
                joblib==1.0.1 \
                numpy \
                pandas==1.1.5 \
                scikit-learn==0.20.3 \
                scipy==1.2.1 \
                seaborn==0.9.0 \
                japanize-matplotlib \
                influxdb \
                influxdb-client \
                ccxt \
                mplfinance \
                Ta-Lib \
                git+https://github.com/twopirllc/pandas-ta \
                hyperas \
                git+https://github.com/pfnet-research/xfeat.git
RUN conda install -y tensorflow-gpu keras
RUN pip install backtesting gast==0.2.2 tensorflow-datasets
RUN pip install omegaconf torch pytorch-lightning torchvision influxdb-client line-bot-sdk

RUN apt install -y gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget


ARG USERNAME=jnbuser
ARG GROUPNAME=jnbuser
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID $USERNAME