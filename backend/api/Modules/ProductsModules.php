<?php

namespace Modules;

final class ProductsModules extends BaseModule
{
    // Get products with pagination
    public function getProducts(int $id_init = 0, int $pagination_number = 30): array {
        $query = "CALL get_products_active(?, ?);"; // Use placeholders
        return $this->getAllRows($query, [$id_init, $pagination_number]); // Pass parameters
    }

    // Get a single product by ID
    public function getProductById(int $id): ?array {
        $query = "CALL get_products_by_id(?);";
        return $this->getSingleRow($query, [ $id ]); // Pass the ID as a parameter
    }
}