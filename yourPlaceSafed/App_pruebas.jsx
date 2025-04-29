// Codigo reac-native
import React, { useEffect, useState } from "react";
import { View , StyleSheet } from "react-native";
import { NavigationContainer } from "@react-navigation/native";
import { createNativeStackNavigator } from "@react-navigation/native-stack";
import { colors } from "./assets/css/colors"

import NavList from "./utils/NavList"
import Home from "./screens/Home";
import ServiceProducts from "./screens/ServiceProducts"

const Stack = createNativeStackNavigator();

//<NavList style={ styles.nav }/>
// Main App component
const App = () => {
  return (
    <NavigationContainer>
     <View style={styles.appContainer}>
      
      
      <View style={styles.pageContent}>
        <Stack.Navigator screenOptions={{ headerShown: false }}>
           
            <Stack.Screen name="Home" component={Home} />  
            <Stack.Screen name="ServiceProducts" component={ServiceProducts} />           
  
        </Stack.Navigator>
      </View>
     </View>
    </NavigationContainer>
   );
 }
 
 const styles = StyleSheet.create({
   appContainer: {
     flex: 1
    ,flexDirection: "row"
   },
 
   pageContent: {
     flex: 1
    ,backgroundColor: colors[900]
    ,paddingVertical: 10
   }
 });
 

export default App;