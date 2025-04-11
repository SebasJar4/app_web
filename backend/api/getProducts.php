<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

if (!isset($_GET['service_id'])) {
    echo json_encode(['error' => 'Missing service_id']);
    exit;
}

$service_id = intval($_GET['service_id']);

require_once '../config/db.php';
$db = new DB();
$conn = $db->getConnection();

$stmt = $conn->prepare("
    SELECT p.products_id, p.products_name, p.products_description, i.imgs_url
    FROM service_products sp
    JOIN products p ON sp.products_id = p.products_id
    JOIN imgs i ON sp.imgs_id = i.imgs_id
    WHERE sp.service_id = ? AND sp.state_objets_id = 1
");
$stmt->bind_param("i", $service_id);
$stmt->execute();

$result = $stmt->get_result();
$products = [];

while ($row = $result->fetch_assoc()) {
    $products[] = $row;
}

echo json_encode($products);
