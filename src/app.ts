interface Product {
    id: number,
    name: string,
    price: number
};

object Product2 {
    id, name, price
};
getProduct : id: number =>  Product = function (id: string) {
    return {
        id: id ,
        name: `Awesome Gadget ${id}`,
        price: 99.5
    }
}
const product = getProduct(1)

console.log (`The product ${product.name} costs $${product.price}`);
const heading = document.createElement('h1');
// const heading = document.querySelector('h1');
heading.textContent = "hello product";
document.body.appendChild(heading);
