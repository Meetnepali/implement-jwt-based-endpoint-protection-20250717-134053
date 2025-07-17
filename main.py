from fastapi import FastAPI, BackgroundTasks, HTTPException
from pydantic import BaseModel, EmailStr
import uvicorn

app = FastAPI()

class UserRegister(BaseModel):
    username: str
    email: EmailStr

# Stub DB store (not persistent, for demo only)
users = {}

def send_welcome_email(email: str):
    print(f"[EMAIL] Sent welcome email to {email}")

@app.post("/register")
async def register(user: UserRegister, background_tasks: BackgroundTasks):
    if user.username in users:
        raise HTTPException(status_code=400, detail="Username already exists")
    users[user.username] = user.email
    # The intention is to schedule the welcome email in the background
    # Please investigate and fix if the email is not being printed
    background_tasks.add_task(send_welcome_email, user.email)
    return {"msg": f"User {user.username} registered"}

if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=False)