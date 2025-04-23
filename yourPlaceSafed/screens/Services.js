import React, { useEffect, useState } from 'react';

import { View, Text, FlatList, Image, StyleSheet } from 'react-native';

import { getServices } from '../services/getServices';

import { rutes } from '../services/getNav';

import colors from "../assets/css/colors";

const Services = () => {
  const [services, setServices] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      const result = await getServices();
      console.log("Servicios recibidos:", result);
      setServices(result);
    };

    fetchData();
  }, []);

  const renderItem = ({ item }) => {
    // Asegúrate de que item.imgs_url sea algo como "defauld.png"
    const imageUrl = "http://" + rutes.host + "serverSvg.php?file=" + item.imgs_url;
    console.log("IMG URL:", imageUrl);

    return (
      <View style={styles.card}>
        <Image
          source={{ uri: ( imageUrl ) }}
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
    flex: 1
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
    backgroundColor: '#eee', // fondo por si no carga la imagen
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
    color: '#666',
  },
  discount: {
    marginTop: 5,
    color: 'green',
  },
});

export default Services;
