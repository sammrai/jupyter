FROM continuumio/anaconda3:2019.03

# shap用にg++とgccをインストールします
RUN apt-get update
RUN apt-get install -y --no-install-recommends g++ gcc libgl1-mesa-dev

# 必要なライブラリをインストールします
RUN pip install --upgrade pip
RUN pip install shap==0.37.0 slicer==0.0.3 xgboost==1.3.0.post0 opencv-contrib-python
RUN conda install -y tensorflow-gpu keras

