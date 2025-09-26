

from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class Product(BaseModel):
    id: int
    name: str
    price: float
    tax: float

# This is where products are inserted
products = [
    Product(id=1, name="Beef Stews", price=135.00, tax=13.00),
    Product(id=2, name="Nshima with Vimbombo", price=150.00, tax=15.00),
    Product(id=3, name= "Nshima with Kapenta", price=100.00, tax=10.00),


]

@app.post("/products")
def create_product(product: Product):
    products.append(product)
    return product

@app.get("/products")
def list_products():
    return products

@app.put("/products/{product_id}")
def update_product(product_id: int, updated: Product):
    for i, p in enumerate(products):
        if p.id == product_id:
            products[i] = updated
            return updated
    return {"error": "Product not found"}

@app.delete("/products/{product_id}")
def delete_product(product_id: int):
    global products
    products = [p for p in products if p.id != product_id]
    return {"message": "Deleted"}