import React, { useEffect } from "react";
import { View, Text, StyleSheet, ScrollView } from "react-native";
import { colors } from "../assets/css/colors";
import Carrusel from "../utils/Carrousel"; 

export default function Home() {
  
  return (
    <ScrollView style={styles.container}>
      <View style={{flex:1}}>
        <View style={ styles.container_title }>
          <Text style = { [ styles.title, styles.Text ] }> Bienvenido a la página principal </Text>
        </View>
        <View style={styles.container_carousel}>
          <Carrusel />
        </View> 
      </View>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1
    ,width: "100%"
    ,height: "auto"
    ,padding: 20
    ,backgroundColor: colors[800]
    ,display: "flex"
    ,flexDirection: "colums"
  },

  container_title: {
     width: "100%"
    ,height: "auto"

  },
  
  title: {
    fontSize: 24,
  },
  
  Text: {
    color: colors[200]
   ,backgroundColor: colors[950] + "dd"
   ,alignSelf: "center"
   ,padding: 10
   ,borderRadius: 10
   ,fontWeight: "bold"
   ,textShadow: `${colors[800]} 1px 1px 2px`
  },

  container_carousel: {
    flex:1
    ,flexDirection: "column"
    ,backgroundColor: "#0f0"
    ,marginTop: "2rem"
  }
});
