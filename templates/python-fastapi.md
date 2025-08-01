# 🐍 {{_project_name_}} - Python FastAPI Project

Modern Python API built with FastAPI, async/await, and best practices for mobile backends.

## 🛠 Tech Stack

- **FastAPI** - Modern, fast web framework for APIs
- **Pydantic** - Data validation using Python type hints
- **SQLAlchemy** - SQL toolkit and ORM
- **Alembic** - Database migration tool
- **pytest** - Testing framework
- **Black & isort** - Code formatting
- **MyPy** - Static type checking

## 🚀 Quick Start

```bash
# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Run development server
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

# Run tests
pytest

# Format code
black . && isort .

# Type checking
mypy .
```

## 📱 Mobile API Features

This API is designed for mobile applications:

- **Fast Response Times** - Optimized for mobile networks
- **Minimal Data Transfer** - Efficient JSON responses
- **Offline Support** - Proper caching headers
- **Push Notifications** - Firebase/APNs integration ready
- **File Upload** - Optimized for mobile image/video uploads
- **Rate Limiting** - Protect against abuse
- **CORS Support** - Ready for web and mobile apps

## 🏗 Project Structure

```
{{_project_name_}}/
├── app/
│   ├── api/
│   │   ├── v1/
│   │   │   ├── endpoints/
│   │   │   └── __init__.py
│   │   └── __init__.py
│   ├── core/
│   │   ├── config.py
│   │   ├── security.py
│   │   └── __init__.py
│   ├── db/
│   │   ├── base.py
│   │   ├── session.py
│   │   └── __init__.py
│   ├── models/
│   ├── schemas/
│   ├── services/
│   ├── main.py
│   └── __init__.py
├── alembic/
├── tests/
├── requirements.txt
├── requirements-dev.txt
├── alembic.ini
├── pytest.ini
├── pyproject.toml
└── README.md
```

## 🔧 Environment Setup

Create a `.env` file:

```env
# Database
DATABASE_URL=sqlite:///./{{_project_name_}}.db

# Security
SECRET_KEY=your-secret-key-here
ACCESS_TOKEN_EXPIRE_MINUTES=30

# API Settings
API_V1_STR=/api/v1
PROJECT_NAME={{_project_name_}}

# CORS
BACKEND_CORS_ORIGINS=["http://localhost:3000", "http://localhost:8080"]

# External Services
REDIS_URL=redis://localhost:6379
CELERY_BROKER_URL=redis://localhost:6379
```

## 🔐 Authentication

JWT-based authentication with refresh tokens:

```python
from app.api.deps import get_current_user
from app.models import User

@router.get("/protected")
async def protected_route(current_user: User = Depends(get_current_user)):
    return {"message": f"Hello {current_user.email}"}
```

## 📊 Database

Using SQLAlchemy with Alembic migrations:

```bash
# Create migration
alembic revision --autogenerate -m "Add user table"

# Apply migrations
alembic upgrade head

# Downgrade
alembic downgrade -1
```

## 🧪 Testing

Comprehensive testing with pytest:

```bash
# Run all tests
pytest

# Run with coverage
pytest --cov=app --cov-report=html

# Run specific test file
pytest tests/test_users.py

# Run with verbose output
pytest -v
```

Example test:

```python
def test_create_user(client: TestClient):
    data = {"email": "test@example.com", "password": "testpass"}
    response = client.post("/api/v1/users/", json=data)
    assert response.status_code == 200
    user = response.json()
    assert user["email"] == "test@example.com"
```

## 📱 Mobile-Specific Endpoints

### File Upload for Mobile
```python
@router.post("/upload/image")
async def upload_image(
    file: UploadFile = File(...),
    current_user: User = Depends(get_current_user)
):
    # Validate image
    if not file.content_type.startswith("image/"):
        raise HTTPException(400, "File must be an image")
    
    # Compress for mobile
    image = await compress_image(file)
    
    # Save to storage
    url = await save_image(image, current_user.id)
    
    return {"url": url, "compressed": True}
```

### Push Notifications
```python
@router.post("/notifications/send")
async def send_push_notification(
    notification: NotificationCreate,
    current_user: User = Depends(get_current_user)
):
    await push_service.send_notification(
        user_id=current_user.id,
        title=notification.title,
        body=notification.body,
        data=notification.data
    )
    return {"status": "sent"}
```

## 🚀 Deployment

### Docker
```bash
# Build image
docker build -t {{_project_name_}} .

# Run container
docker run -p 8000:8000 {{_project_name_}}
```

### Heroku
```bash
# Login to Heroku
heroku login

# Create app
heroku create {{_project_name_}}

# Set environment variables
heroku config:set SECRET_KEY=your-secret-key

# Deploy
git push heroku main
```

### Railway
```bash
# Install Railway CLI
npm install -g @railway/cli

# Login and deploy
railway login
railway init
railway up
```

## 📊 API Documentation

FastAPI automatically generates API documentation:

- **Swagger UI**: http://localhost:8000/docs
- **ReDoc**: http://localhost:8000/redoc
- **OpenAPI JSON**: http://localhost:8000/openapi.json

## 🔧 Development Tools

### Code Quality
```bash
# Format code
black .
isort .

# Lint
flake8 .

# Type checking
mypy .

# Security check
bandit -r app/
```

### Database Management
```bash
# Create new migration
alembic revision --autogenerate -m "Description"

# Apply migrations
alembic upgrade head

# See migration history
alembic history

# Downgrade
alembic downgrade -1
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Install development dependencies (`pip install -r requirements-dev.txt`)
4. Make your changes
5. Run tests (`pytest`)
6. Format code (`black . && isort .`)
7. Commit your changes (`git commit -m 'Add some amazing feature'`)
8. Push to the branch (`git push origin feature/amazing-feature`)
9. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- FastAPI team for the amazing framework
- Pydantic for data validation
- SQLAlchemy for the excellent ORM
- pytest for testing capabilities

---

**Happy coding! 🐍🚀**