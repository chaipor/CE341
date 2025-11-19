# ใช้ Python 3.9 บน Alpine Linux เป็น Base Image
# Alpine เป็น Base Image ขนาดเล็กและปลอดภัย
FROM python:3.9-alpine

# ENV PYTHONUNBUFFERED 1: ตั้งค่าให้ Python output ไม่ต้องรอการบัฟเฟอร์ 
# ซึ่งมีประโยชน์อย่างยิ่งในการดู Log ของแอปพลิเคชันแบบ Real-time ใน Docker
# ป้องกันไม่ให้ Python สร้างไฟล์ .pyc และให้ log แสดงทันที
ENV PIP_DISABLE_PIP_VERSION_CHECK=1
ENV PIP_ROOT_USER_ACTION=ignore
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# กำหนด Working Directory ภายใน Container
# WORKDIR /app: เป็นการตั้งค่าโฟลเดอร์เริ่มต้นที่จะใช้สำหรับคำสั่ง RUN, CMD, COPY และ ADD
WORKDIR /app

# คัดลอกไฟล์ requirements.txt เข้าไปใน container
COPY requirements.txt .

# อัปเดต pip เพื่อไม่ให้เตือน
RUN pip install --no-cache-dir --upgrade pip

# ติดตั้ง Flask
RUN pip install --no-cache-dir -r requirements.txt

# คัดลอกไฟล์แอปพลิเคชัน Flask ที่อยู่ใน path src เข้าไปใน container ที่ WORKDIR (/app) 
COPY src/ .

# เปิดเผยพอร์ต (Expose Port)
# EXPOSE 80: เป็นการประกาศ (Metadata) ให้ผู้ใช้ทราบว่า Container นี้รันบริการบนพอร์ต 80
EXPOSE 80

# คำสั่งเริ่มต้นเมื่อ Container ถูกรัน
# CMD ["python", "app.py"]: เป็นคำสั่งสุดท้ายที่จะรัน เมื่อ Container ถูกสร้างและเริ่มต้นขึ้น
CMD ["python", "app.py"]
