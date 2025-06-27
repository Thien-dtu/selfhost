# 🌐 Self-Hosted Services Overview

📅 Đây là hệ thống các dịch vụ tự host của tôi, sử dụng Docker Compose để triển khai và quản lý trên mạng nội bộ. File này ghi chú địa chỉ truy cập, mục đích sử dụng, cấu trúc thư mục, và sơ đồ kiến trúc hệ thống.

---

## 🧭 Dịch vụ & Cổng truy cập

| Dịch vụ           | Cổng         | Địa chỉ                             | Mô tả ngắn                                 |
|------------------|--------------|-------------------------------------|--------------------------------------------|
| Dashy            | `4000`       | http://localhost:4000              | Bảng điều khiển tổng hợp tất cả dịch vụ    |
| Nginx Proxy Mgr  | `81`, `443`  | http://localhost:81                | Quản lý reverse proxy & SSL (NPM)          |
| Portainer        | `9000`       | http://localhost:9000              | Quản lý container Docker dễ dàng           |
| Uptime Kuma      | `3001`       | http://localhost:3001              | Giám sát trạng thái các dịch vụ            |
| Vaultwarden      | `8080`       | http://localhost:8080              | Trình quản lý mật khẩu Bitwarden self-host |
| Jellyfin         | `8096`       | http://localhost:8096              | Media server để xem phim/nhạc              |
| Nextcloud        | `8081`       | http://localhost:8081              | Lưu trữ, đồng bộ file                       |
| AdGuard Home     | `3000`, `53` | http://localhost:3000              | Chặn quảng cáo, DNS server                  |
| Speedtest Tracker| `8765`       | http://localhost:8765              | Theo dõi tốc độ mạng định kỳ                |
| Bookstack        | `6875`       | http://localhost:6875              | Quản lý ghi chú, wiki cá nhân               |
| Paperless NGX    | `8000`       | http://localhost:8000              | Lưu trữ và tìm kiếm tài liệu scan          |
| DuckDNS          | -            | -                                   | Cập nhật địa chỉ IP động                    |
| Watchtower       | -            | -                                   | Tự động cập nhật image Docker              |

---

## 📁 Cấu trúc thư mục

```
~/selfhost
├── docker-compose.yml
├── .env
├── data/
│   ├── dashy/
│   ├── npm/
│   ├── portainer/
│   ├── uptime-kuma/
│   ├── vaultwarden/
│   ├── jellyfin/
│   ├── nextcloud/
│   ├── nextcloud_db/
│   ├── adguard/
│   ├── speedtest-tracker/
│   ├── speedtest-db/
│   ├── bookstack/
│   ├── bookstack_db/
│   ├── paperless/
│   └── paperless_db/
├── media/
│   ├── paperless/
│   │   ├── media/
│   │   ├── export/
│   │   └── consume/
│   └── (thư mục chứa file media cho Jellyfin)
```

---

## 🗂️ Sơ đồ kiến trúc

```
                                 ┌───────────────┐
                                 │    Internet   │
                                 └──────┬────────┘
                                        │
                                        ▼
                             ┌────────────────────┐
                             │    Nginx Proxy Mgr │
                             └────────┬───────────┘
                                      │
     ┌────────────────────────────┬────────────────────────────┬
     ▼                            ▼                            ▼
 Dashy (4000)              Vaultwarden (8080)            Nextcloud (8081)
     ▼                            ▼                            ▼
 Bookstack (6875)           Speedtest Tracker (8765)       Paperless NGX (8000)
     │                            │                            │
     ▼                            ▼                            ▼
 MariaDB                    MariaDB                    MariaDB

     ┌────────────────────────────────────────────────────────┐
     │                      Portainer (9000)                  │
     └────────────────────────────────────────────────────────┘

                       (Mạng bridge Docker: `selfnet`)
```

---

## 🔐 Quản lý mật khẩu & truy cập

- Vaultwarden dùng để lưu trữ tất cả tài khoản, mật khẩu dịch vụ.
- Sử dụng `.env` để quản lý biến môi trường như mật khẩu root DB, token DuckDNS,...
- Nên backup định kỳ thư mục `data/` và `media/`.

---

## 🔄 Tự động cập nhật & DNS động

- Watchtower sẽ tự cập nhật image container mỗi 24h.
- DuckDNS giúp cập nhật IP động cho domain `*.duckdns.org`.

---

## 📌 Ghi chú

- Nên đặt cron backup dữ liệu quan trọng (Nextcloud, Paperless, Vaultwarden).
- Có thể thêm Cloudflare Tunnel nếu không dùng DuckDNS + mở port.
- Một số container có healthcheck ngầm (ví dụ `speedtest-db`).

---

## ✅ DONE ✅

File này sẽ giúp bạn dễ nhớ và quản lý hệ thống self-host của mình hiệu quả hơn!
