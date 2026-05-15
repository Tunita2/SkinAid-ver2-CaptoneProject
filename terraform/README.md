# SkinAid-v2 Terraform Deployment

Thư mục này chứa mã Terraform để triển khai kiến trúc AWS cho dự án SkinAid-v2 theo thiết kế High Availability.

## 📌 Các thành phần được triển khai

Kiến trúc triển khai bám sát sơ đồ, bao gồm:
1. **Network (`vpc.tf`)**: VPC, 2 Public Subnets, 4 Private Subnets (App & DB) trải trên 2 AZ, Internet Gateway, và NAT Gateway.
2. **Security (`security_groups.tf`)**: Phân tách Security Group chặt chẽ cho ALB, Backend, AI Service và Database.
3. **Load Balancing (`alb.tf`)**: Internal Application Load Balancer để phân tải vào các Backend EC2.
4. **Compute (`compute.tf`)**: Các máy chủ EC2 nằm trong Private Subnet cho Backend (FastAPI, Redis) và AI Services (YOLO, EfficientNet).
5. **Database (`rds.tf`)**: PostgreSQL RDS chạy ở chế độ Multi-AZ (Primary & Standby).
6. **Storage & CDN (`s3_cloudfront.tf`)**: S3 lưu trữ frontend, S3 lưu trữ hình ảnh (với VPC Endpoint Gateway), và CloudFront cấu hình VPC Origin để truy cập Internal ALB.
7. **Ràng buộc an toàn (`providers.tf`)**: Giới hạn triển khai chỉ trên tài khoản Lab (`910012064913`).

## 🚀 Hướng dẫn triển khai

Yêu cầu:
- Đã cài đặt [Terraform](https://developer.hashicorp.com/terraform/downloads) (phiên bản >= 1.5.0)
- Đã cấu hình AWS CLI credentials cho tài khoản Lab.

### Bước 1: Khởi tạo Terraform
Lệnh này sẽ tải các provider plugins cần thiết (AWS provider).
```bash
terraform init
```

### Bước 2: Kiểm tra kế hoạch triển khai
Lệnh này giúp bạn xem trước những tài nguyên nào sẽ được tạo trên AWS mà chưa thực sự tạo chúng.
```bash
terraform plan
```

### Bước 3: Triển khai lên AWS
Nếu kế hoạch (plan) chính xác, chạy lệnh sau để tiến hành tạo tài nguyên. Gõ `yes` khi được hỏi.
```bash
terraform apply
```

### Bước 4: Hủy tài nguyên (khi làm xong Lab)
Để tránh phát sinh chi phí trên tài khoản Lab, bạn nên xóa tài nguyên khi không còn sử dụng.
```bash
terraform destroy
```

## ⚠️ Lưu ý
- Các mật khẩu database và thông tin nhạy cảm trong `variables.tf` hiện đang để mặc định. Trong thực tế cần dùng AWS Secrets Manager hoặc truyền qua biến môi trường (`TF_VAR_db_password`).
- Tính năng **VPC Origin** của CloudFront có thể yêu cầu cấu hình bổ sung trên AWS (tạo managed prefix list cho Security Group). Ở phiên bản code này sử dụng Custom Origin hướng tới DNS của Internal ALB để đơn giản hóa.
