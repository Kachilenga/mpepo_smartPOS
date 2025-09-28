from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class Product(BaseModel):
    id: int
    name: str
    price: float
    tax: float

products = [
    Product(id=1, name="Beef Stew Deluxe", price=135.00, tax=13.00),
    Product(id=2, name="Nshima with Vimbombo", price=150.00, tax=15.00),
    Product(id=3, name="Nshima with Kapenta", price=100.00, tax=10.00),
]

@app.get("/products")
def list_products():
    return products