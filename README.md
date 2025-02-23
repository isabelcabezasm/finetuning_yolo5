# Fine Tunning YOLO v5

For my [chapGPT](https://github.com/isabelcabezasm/chapgpt) I needed to find one or more caps in the image that the user gives to the bot.
The typical/most famous algorithms of image/object detection don't recognize the caps, the classes like "bottle", "hand", "chair".. but not a bottle cap.

To achieve it I made my own version of YOLO v5. 

You can find how I made it, step by step, here.

General, official, documentation ref:

1) Official ultralytics YOLO v5 documentation: 
https://docs.ultralytics.com/yolov5/

2) YOLOv5 repo:
https://github.com/ultralytics/yolov5

3) Train with Custom Data:
https://docs.ultralytics.com/yolov5/tutorials/train_custom_data/

## Fine tuning for caps

1. Label my caps. Selected 77 images (check an example in the folder `datasets`) and labeled them with [LabelImg](https://github.com/HumanSignal/labelImg). Select Output "YOLO".

1. Create folders `/images` with all the images and `/labels` with all the labels.

1. Files `test.txt`, `train.txt` and `val.txt` with the images (paths) that we are going to use for train (37), test (24) and validation (16).

1. Use/clone the [Yolo v5 repo](https://github.com/ultralytics/yolov5https://github.com/ultralytics/yolov5) to train/finetune the model.

1. Create a file `data.yaml` in the []`data` folder of the repo](https://github.com/ultralytics/yolov5/tree/master/data).
Check the format in my [`caps.yaml`](caps.yaml). 

1. I opened the repo in my `.devcontainer` container, because it's working for me and detecting well my GPU(s).

1. The folder `datasets` needs to be in the same workspace that `yolo5` directory, at the same level.

1. Train. I executed:

```bash
$ python train.py --data caps.yaml --weights yolov5s.pt --img 500 
```

where the `caps.yaml` is the file in the repo with the same name. I set as a base the second smaller model `yolov5s` and my images has a dimension of 500x500, but they must be multiple of 32, so it automatically updates them to 512. 

I left the default hyperparameters:

- weights=yolov5 (yolo v5 small)
- epochs=100
- batch_size=16
- imgsz=500
- optimizer=SGD
- lr0=0.01, 
- lrf=0.01, 
- momentum=0.937 

It took 6 minutes and 18 seconds in total:
100 epochs completed in 0.105 hours.

The best and the last were exp11, in our case.
- Optimizer stripped from runs/train/exp11/weights/last.pt, 14.4MB
- Optimizer stripped from runs/train/exp11/weights/best.pt, 14.4MB

P = 0.9407
R = 0.8817

Check the model in `best_run` folder.
