import React, { useEffect, useState } from 'react';
import { View, Text, ActivityIndicator, StyleSheet } from 'react-native';
import { getServices } from '../services/getServices'; 
import { colors } from '../assets/css/colors';


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
    return <Text style={styles.errorText}>{error}</Text>;
  }

  return (
    <View style={styles.container}>
      {services.length > 0 ? (
        services.map((service, index) => (
          <Text key={index} style={styles.serviceText}>
            {service.serviceName} {/* Adjust based on your service object structure */}
          </Text>
        ))
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
    backgroundColor: "#156"
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
});

export default CarruselComponent;