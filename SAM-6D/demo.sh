export CAD_PATH=/kaggle/working/SAM-6D/SAM-6D/Data/Example/obj_000020.ply    # path to a given cad model(mm)
export RGB_PATH=/kaggle/working/SAM-6D/SAM-6D/Data/Example/000020.jpg          # path to a given RGB image
export DEPTH_PATH=/kaggle/working/SAM-6D/SAM-6D/Data/Example/000020_depth.png       # path to a given depth map(mm)
export CAMERA_PATH=/kaggle/working/SAM-6D/SAM-6D/Data/Example/camera1.json    # path to given camera intrinsics
export OUTPUT_DIR=/kaggle/working/SAM-6D/SAM-6D/Data/Example/outputs 

# Render CAD templates
cd Render
blenderproc run render_custom_templates.py --output_dir $OUTPUT_DIR --cad_path $CAD_PATH #--colorize True 

# Run instance segmentation model
export SEGMENTOR_MODEL=sam

cd ../Instance_Segmentation_Model
python run_inference_custom.py --segmentor_model $SEGMENTOR_MODEL --output_dir $OUTPUT_DIR --cad_path $CAD_PATH --rgb_path $RGB_PATH --depth_path $DEPTH_PATH --cam_path $CAMERA_PATH


# Run pose estimation model
export SEG_PATH=$OUTPUT_DIR/sam6d_results/detection_ism.json

cd ../Pose_Estimation_Model
python run_inference_custom.py --output_dir $OUTPUT_DIR --cad_path $CAD_PATH --rgb_path $RGB_PATH --depth_path $DEPTH_PATH --cam_path $CAMERA_PATH --seg_path $SEG_PATH
