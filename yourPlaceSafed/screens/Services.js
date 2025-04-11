import React, { useEffect, useState } from 'react';
import { View, Text, FlatList, Image, StyleSheet } from 'react-native';
import { getServices } from '../services/getServices';

const Services = () => {
  const [services, setServices] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      const result = await getServices();
      setServices(result);
    };

    fetchData();
  }, []);

  const renderItem = ({ item }) => (
    <View style={styles.card}>
      <Image
        source={{ uri: 'http://localhost' + item.imgs_url }}
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

  return (
    <FlatList
      data={services}
      keyExtractor={(item) => item.servicie_id.toString()}
      renderItem={renderItem}
      contentContainerStyle={styles.container}
    />
  );
};

const styles = StyleSheet.create({
  container: {
    padding: 10,
  },
  card: {
    flexDirection: 'row',
    marginBottom: 15,
    backgroundColor: '#fff',
    borderRadius: 10,
    overflow: 'hidden',
    elevation: 2,
  },
  image: {
    width: 100,
    height: 100,
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
