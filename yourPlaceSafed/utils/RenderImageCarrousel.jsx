import { useNavigation } from "@react-navigation/native";
import { View, Text, Image, Button } from "react-native";
import { SvgUri } from 'react-native-svg';
import { StyleSheet } from "react-native";
import { LinearGradient } from "expo-linear-gradient";
import ServiceProducts from "../screens/ServiceProducts";
// Renderiza una imagen
export const RenderImageCarrousel = ({ item }) => {
  const navigation = useNavigation();
  const { id, name, url, isSvg, description, serviceId } = item;

  const handlePress = () => {
    navigation.navigate('ServiceProducts', { service_id: serviceId , service_name: name });
  };

  return (
    <View key={"container" + id} style={styles.imageContainer}>
      {isSvg ? (
        <SvgUri uri={url} width={100} height={100} />
      ) : (
        <Image source={{ uri: url }} style={styles.image} />
      )}
      <View style={styles.textContainer}>
        <LinearGradient colors={['#00000000', '#00000011', '#000000a']} width={100} height={100} >
          <Text>{name}</Text>
          <Text>{description}</Text>
          <Button onPress={handlePress} title="Ver más ➡️" />
        </LinearGradient>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  imageContainer: {
    width: 200, // Set a fixed width for each item
    height: 300, // Set a fixed height for each item
    marginRight: 10, // Add some margin between items
  },
  textContainer: {
    position: "absolute"
    ,alignItems: "flex-end"
    ,height: "100%"
    ,width: "100%"
  },
  image: {
    width: "100%",
    height: "100%",
    backgroundColor: '#eee',
  },
});
