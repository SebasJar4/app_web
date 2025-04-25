import React, { useEffect, useState } from "react";
import { View, Text, FlatList, Image, TouchableOpacity, Modal, StyleSheet, ActivityIndicator } from "react-native";
import { useRoute, useNavigation } from "@react-navigation/native";
import { getServiceProducts } from "../services/getServiceProducts";
import { getImg } from "../services/getImg";

const ServiceProducts = () => {
  const route = useRoute();
  const navigation = useNavigation();
  
  // Extraer service_id desde los parámetros de la navegación
  const { service_id, service_name } = route.params || {}; // Asegúrate de que params está definido

  const [products, setProducts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [selectedProduct, setSelectedProduct] = useState(null);

  useEffect(() => {
    if (!service_id) {
      console.error("service_id no está definido en route.params");
      setLoading(false);
      return;
    }

    const loadProducts = async () => {
      try {
        const data = await getServiceProducts(service_id); // Llamada al servicio con service_id
        console.log("Productos recibidos:", data);

        const dataWithImages = data.map((product) => {
          const imgData = getImg(product.imgs_id || ""); // Manejar casos donde imgs_id puede ser inválido
          return {
            ...product,
            imageUrl: imgData?.fullUrl || "", // Asignar una URL vacía si getImg devuelve null
          };
        });

        setProducts(dataWithImages);
      } catch (error) {
        console.error("Error al cargar productos:", error);
      } finally {
        setLoading(false);
      }
    };

    loadProducts();
  }, [service_id]);

  const renderItem = ({ item }) => (
    <TouchableOpacity style={styles.card} onPress={() => setSelectedProduct(item)}>
      <Image source={{ uri: item.imageUrl }} style={styles.image} />
      <Text style={styles.name}>{item.producst_name}</Text>
      <Text style={styles.price}>${item.products_precio}</Text>
    </TouchableOpacity>
  );

  return (
    <View style={styles.container}>
      <TouchableOpacity style={styles.backButton} onPress={() => navigation.goBack()}>
        <Text style={styles.backText}>← Volver</Text>
      </TouchableOpacity>

      <Text style={styles.title}>{service_name || "Productos"}</Text>

      {loading ? (
        <ActivityIndicator size="large" color="#000" />
      ) : (
        <FlatList
          data={products}
          renderItem={renderItem}
          keyExtractor={(item) => item.products_id.toString()}
          numColumns={2}
          contentContainerStyle={styles.list}
        />
      )}

      <Modal visible={!!selectedProduct} transparent animationType="slide">
        <View style={styles.modalContainer}>
          {selectedProduct && (
            <View style={styles.modalContent}>
              <Image source={{ uri: selectedProduct.imageUrl }} style={styles.modalImage} />
              <Text style={styles.modalTitle}>{selectedProduct.producst_name}</Text>
              <Text style={styles.modalDescription}>{selectedProduct.products_description}</Text>
              <Text style={styles.modalPrice}>Precio: ${selectedProduct.products_precio}</Text>
              <TouchableOpacity onPress={() => setSelectedProduct(null)} style={styles.closeButton}>
                <Text style={styles.closeText}>Cerrar</Text>
              </TouchableOpacity>
            </View>
          )}
        </View>
      </Modal>
    </View>
  );
};

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: "#f4f4f4" },
  backButton: { padding: 10 },
  backText: { fontSize: 16 },
  title: { fontSize: 24, fontWeight: "bold", textAlign: "center", marginBottom: 10 },
  list: { padding: 10 },
  card: {
    flex: 1,
    margin: 5,
    backgroundColor: "#fff",
    borderRadius: 10,
    padding: 10,
    alignItems: "center",
    elevation: 3,
  },
  image: { width: 100, height: 100, resizeMode: "cover", borderRadius: 10 },
  name: { fontSize: 14, fontWeight: "bold", marginTop: 5 },
  price: { fontSize: 12, color: "#888" },
  modalContainer: { flex: 1, backgroundColor: "rgba(0,0,0,0.5)", justifyContent: "center" },
  modalContent: { margin: 20, padding: 20, backgroundColor: "#fff", borderRadius: 10, alignItems: "center" },
  modalImage: { width: 200, height: 200, marginBottom: 10 },
  modalTitle: { fontSize: 20, fontWeight: "bold" },
  modalDescription: { fontSize: 14, marginVertical: 10 },
  modalPrice: { fontSize: 16, fontWeight: "bold" },
  closeButton: { marginTop: 10 },
  closeText: { color: "#007bff" },
});

export default ServiceProducts;
