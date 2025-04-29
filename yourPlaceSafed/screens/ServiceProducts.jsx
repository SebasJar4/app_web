import React, { useEffect, useState } from "react";
import { View, Text, FlatList, Image, TouchableOpacity, Modal, StyleSheet, ActivityIndicator } from "react-native";
import { useRoute, useNavigation } from "@react-navigation/native";
import { getServiceProducts } from "../services/getServiceProducts";
import { getImg, getImgById } from "../services/getImg";
import { colors } from "../assets/css/colors";

const ServiceProducts = () => {
  const route = useRoute();
  const navigation = useNavigation();
  const { service_id, service_name } = route.params || {};
  
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
        const data = await getServiceProducts({ service_id: service_id }); // Fetch products
    
        console.log(data);
        
        // Use Promise.all to wait for all image fetches to complete
        const dataWithImages = await Promise.all(data.map(async (product) => {
          const img_fetch = await getImgById(product.imgs_id); // Fetch image by ID
          const imgData = getImg(img_fetch.imgs_url); // Get image data
          return {
            ...product,
            imgs_url: imgData.fullUrl, // Set the image URL
            isSvg: imgData.isSvg, // Set if the image is SVG
          };
        }));
    
        console.log(dataWithImages);
        setProducts(dataWithImages); // Set the products state
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
      <Image source={{ uri: item.imgs_url }} style={styles.image} />
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
              <Image source={{ uri: selectedProduct.imgs_url }} style={styles.modalImage} />
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
  container: { flex: 1, backgroundColor: colors[900] },
  backButton: { padding: 10 },
  backText: { 
    textAlign: "center"
   ,fontSize: 16
   ,backgroundColor: colors[300] 
   ,padding: 10 
   ,width: "auto"
  },
  title: { 
    fontSize: 24
   ,fontWeight: "bold"
   ,textAlign: "center"
   ,marginBottom: 10 
   ,color: colors[100]
  },
  list: { padding: 10 },
  card: {
    flex: 1,
    margin: 5,
    backgroundColor: colors[300],
    borderRadius: 10,
    padding: 10,
    alignItems: "center",
    elevation: 3,
  },
  image: { width: 100, height: 100, resizeMode: "cover", borderRadius: 10 },
  name: { fontSize: 14, fontWeight: "bold", marginTop: 5 },
  price: { fontSize: 12, color: "#888" },
  modalContainer: { 
    flex: 1
   ,backgroundColor: colors[1000] + "66"
   ,justifyContent: "center" 
  },
  modalContent: { margin: 20, padding: 20, backgroundColor: colors[300], borderRadius: 10, alignItems: "center" },
  modalImage: { width: 200, height: 200, marginBottom: 10 },
  modalTitle: { fontSize: 20, fontWeight: "bold" },
  modalDescription: { fontSize: 14, marginVertical: 10 },
  modalPrice: { fontSize: 16, fontWeight: "bold" },
  closeButton: { marginTop: 10 },
  closeText: { color: "#007bff" },
});

export default ServiceProducts;
