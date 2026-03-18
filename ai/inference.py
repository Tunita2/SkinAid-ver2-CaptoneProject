from typing import Dict


def predict_stage1(image_bytes: bytes) -> Dict:
    raise NotImplementedError("Implement stage1 model inference")


def predict_stage2(image_bytes: bytes) -> Dict:
    raise NotImplementedError("Implement stage2 model inference")
