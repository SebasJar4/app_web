import React, { useEffect, useState } from "react";
import { View, Text, Image, StyleSheet, Dimensions, ActivityIndicator } from "react-native";
import Carousel from "react-native-snap-carousel";
import { getServices } from "../services/getServices";
import { rutes } from "../services/getNav";
import colors from "../assets/css/colors";

const { width: screenWidth } = Dimensions.get("window");

export default function ServiceCarousel() {
  const [services, setServices] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    (async () => {
      try {
        const data = await getServices();
        setServices(data);
      } catch (err) {
        console.error("Error cargando servicios:", err);
      } finally {
        setLoading(false);
      }
    })();
  }, []);

  const renderItem = ({ item }) => {
    const imageUrl = `http://${rutes.host}serverSvg.php?file=${item.imgs_url}`;

    return (
      <View style={styles.card}>
        <Image
          source={{ uri: imageUrl }}
          style={styles.image}
          resizeMode="cover"
        />
        <View style={styles.info}>
          <Text style={styles.title}>{item.service_name}</Text>
          <Text style={styles.description}>{item.service_description}</Text>
          <Text style={styles.discount}>Descuento: {item.service_descuento}%</Text>
        </View>
      </View>
    );
  };

  if (loading) {
    return <ActivityIndicator size="large" style={{ marginTop: 30 }} color={colors[200]} />;
  }

  if (services.length === 0) {
    return <Text style={{ textAlign: "center", marginTop: 20, color: colors[100] }}>No hay servicios disponibles</Text>;
  }

  return (
    <View style={{ marginTop: 20 }}>
      <Carousel
        data={services}
        renderItem={renderItem}
        sliderWidth={screenWidth}
        itemWidth={screenWidth * 0.85}
        layout="default"
        loop
        autoplay
      />
    </View>
  );
}

const styles = StyleSheet.create({
  card: {
    backgroundColor: colors[800],
    borderRadius: 12,
    padding: 10,
    elevation: 5,
    shadowColor: "#000",
    shadowOpacity: 0.2,
    shadowOffset: { width: 0, height: 3 },
    shadowRadius: 5,
  },
  image: {
    width: "100%",
    height: 160,
    borderRadius: 8,
    marginBottom: 10,
  },
  info: {
    paddingHorizontal: 5,
  },
  title: {
    fontSize: 18,
    fontWeight: "bold",
    color: colors[100],
  },
  description: {
    fontSize: 14,
    color: colors[300],
    marginTop: 4,
  },
  discount: {
    marginTop: 6,
    color: colors.green || "#4caf50", // por si no tienes un verde definido
    fontWeight: "600",
  },
});
