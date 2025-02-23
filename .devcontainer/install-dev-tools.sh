#!/bin/bash

sudo apt update
sudo apt install -y libgl1-mesa-glx
pip install -r requirements.txt --extra-index-url https://pypi.nvidia.com