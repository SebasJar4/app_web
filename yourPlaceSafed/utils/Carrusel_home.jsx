import React, { useEffect, useState } from 'react';
import {
  View
  ,Text
  ,Image
  ,ActivityIndicator
  ,StyleSheet
} from 'react-native';
import Swiper from "react-native-swiper"

import { getServices } from '../services/getServices';
import { colors } from '../assets/css/colors';
import { getImg } from '../services/getImg';

const CarruselComponent = () => {
  const [services, setServices] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchServices = async () => {
      setLoading(true);
      setError(null); // Reset error state before fetching
      try {
        const data = await getServices();
        // console.log("-> GetServices: ", data)
        
        data.map( ( e , i )=>{
          e.imgs_url = getImg(e.imgs_url).fullUrl;
          // console.log( `la img ${i} es:  ${e.imgs_url}` );
        })

        setServices(data);
      } catch (err) {
        setError('Error fetching services');
      } finally {
        setLoading(false);
      }
    };

    fetchServices();
  }, []); // Empty dependency array means this effect runs once when the component mounts

  if (loading) {
    return <ActivityIndicator size="large" color="#0000ff" />;
  }
  
  if (error) {
    return (
      <Text style={styles.errorText} >
        {error}
      </Text>
    );
  }

  return (
    <View style={styles.container}>
      {services.length > 0 ? (
        <Swiper
          style={styles.wrapper}
          showsPagination={true} // Muestra la paginación
          autoplay={true} // Habilita el autoplay
          autoplayTimeout={3} // Tiempo entre cambios de imagen
        >
          {services.map((service, index) => (
            <View key={service.service_id || index} style={styles.slide}>
              <Image
                source={{ uri: service.imgs_url }}
                style={styles.image}
                resizeMode="cover"
              />
            </View>
          ))}
        </Swiper>
      ) : (
        <Text>No services found.</Text>
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: colors[200]
  },
  serviceText: {
    fontSize: 18,
    margin: 10,
    color: colors[100]
  },
  errorText: {
    color: 'red',
    fontSize: 16,
  },
  image: {
    width: 100,
    height: 100,
    backgroundColor: '#eee',
  },
  wrapper: {
    height: 200, // Altura del swiper
  },
  slide: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
});

export default CarruselComponent;