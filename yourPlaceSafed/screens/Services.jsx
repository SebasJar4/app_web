import React, { useEffect, useState } from 'react';
import { View, Text, FlatList, Image, StyleSheet, TouchableOpacity } from 'react-native';
import { useNavigation } from '@react-navigation/native';

import { getServices } from '../services/getServices';
import { getImg } from '../services/getImg';
import { colors } from "../assets/css/colors";

const Services = () => {
  const [services, setServices] = useState([]);
  const navigation = useNavigation();

  useEffect(() => {
    const fetchData = async () => {
      try {
        const result = await getServices(); // Llamada al servicio para obtener los datos
        console.log("Servicios recibidos:", result);
        setServices(result);
      } catch (error) {
        console.error("Error al obtener servicios:", error);
      }
    };

    fetchData();
  }, []);

  const renderItem = ({ item }) => {
    const { fullUrl } = getImg(item.imgs_url); // Obtener la URL de la imagen
    const serviceId = item.service_id || item.servicie_id; // Manejo de casos para nombres incorrectos

    return (
      <TouchableOpacity
        onPress={() => navigation.navigate('ServiceProducts', { service_id: serviceId, service_name: item.service_name })}
        >

        <View style={styles.card}>
          <Image
            source={{ uri: fullUrl }}
            style={styles.image}
            resizeMode="cover"
          />
          <View style={styles.info}>
            <Text style={styles.title}>{item.service_name}</Text>
            <Text style={styles.description}>{item.service_description}</Text>
            <Text style={styles.discount}>Descuento: {item.service_descuento}%</Text>
          </View>
        </View>
      </TouchableOpacity>
    );
  };

  return (
    <FlatList
      data={services}
      keyExtractor={(item) => item.service_id?.toString() || item.servicie_id?.toString()}
      renderItem={renderItem}
      contentContainerStyle={styles.container}
    />
  );
};

const styles = StyleSheet.create({
  container: {
    padding: 10,
    backgroundColor: colors[800],
    flex: 1,
  },
  card: {
    flexDirection: 'row',
    marginBottom: 15,
    backgroundColor: colors[300],
    borderRadius: 10,
    overflow: 'hidden',
    elevation: 2,
  },
  image: {
    width: 100,
    height: 100,
    backgroundColor: '#eee',
  },
  info: {
    flex: 1,
    padding: 10,
  },
  title: {
    fontWeight: 'bold',
    fontSize: 16,
    marginBottom: 5,
  },
  description: {
    color: '#222',
  },
  discount: {
    marginTop: 5,
    color: "#333",
  },
});



export default Services;
