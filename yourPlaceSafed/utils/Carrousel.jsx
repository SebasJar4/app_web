import React, { useEffect, useState } from 'react';
import {
  View,
  Text,
  Image,
  Button,
  ActivityIndicator,
  StyleSheet,
  FlatList,
} from 'react-native';

import { getServices } from "../services/getServices";
import { getImg } from '../services/getImg';
import { colors } from '../assets/css/colors';
import { RenderImageCarrousel } from './RenderImageCarrousel';


// Main carousel component
const Carrusel = () => {
  const [services, setServices] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchServices = async () => {
      setLoading(true);
      setError(null);
      try {
        const data = await getServices();
        const processed = data.map((e) => {
          const consulta = getImg(e.imgs_url);
          return {
            id: e.imgs_id,
            serviceId: e.servicie_id,
            name: e.service_name,
            description: e.service_description,
            discount: e.service_descuento,
            url: consulta.fullUrl,
            isSvg: consulta.isSvg,
          };
        });
        setServices(processed);
      } catch (err) {
        console.error(err);
        setError('Error fetching services');
      } finally {
        setLoading(false);
      }
    };

    fetchServices();
  }, []);

  if (loading) return <ActivityIndicator size="large" color="#00f" style={{ alignSelf: "center", flex: 1 }} />;
  if (error) return <Text style={styles.errorText}>{error}</Text>;

  return (
    <View style={styles.carouselContainer}>
      {services.length > 0 ? (
        <FlatList
          data={services}
          renderItem={({ item }) => <RenderImageCarrousel item={item} />}
          keyExtractor={(item) => item.id.toString()}
          showsHorizontalScrollIndicator={false}
          horizontal={true}
          style={styles.carrusel}
          pagingEnabled={true}
          snapToAlignment="center" // Center the items when scrolling
          snapToInterval={210} // Match this to the width of the items + margin
        />
      ) : (
        <Text>No services found.</Text>
      )}
    </View>
  );
  
};


// Styles
const styles = StyleSheet.create({
  carouselContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: "#000" || colors[200],
    gap: 10,
    height: 300, // Set a fixed height for the carousel
  },
  carrusel: {
    flexGrow: 0, // Prevent the FlatList from growing
    width: '100%', // Make sure it takes the full width
  },
  errorContainer: {
    backgroundColor: "#f00",
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
  errorText: {
    color: "#fff",
    textShadowColor: "#f00",
  },

});


export default Carrusel;