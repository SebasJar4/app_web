// Codigo reac-native
import React, { useEffect, useState } from "react";
import { View , StyleSheet , ScrollView } from "react-native";
import { NavigationContainer } from "@react-navigation/native";
import { createNativeStackNavigator } from "@react-navigation/native-stack";

// Utilidades
import NavList from "./utils/NavList";
// Pantallas base
import Home from "./screens/Home";
import Services from "./screens/Services";
import Login from "./screens/Login";
import Default from "./screens/Default";
import ServiceProducts from './screens/ServiceProducts';

// ...


import { getNavs } from "./services/getNav";
// Stylos base css
import { basicStyles } from "./assets/base_styles";
import { colors } from "./assets/css/colors";



const Stack = createNativeStackNavigator();



export default function App() {
  const [routesFromDB, setRoutesFromDB] = useState([]);

  useEffect(() => {
    (async () => {
      const navs = await getNavs();
      setRoutesFromDB(navs);
    })();
  }, []);



  return (
   <NavigationContainer>
    <View style={styles.appContainer}>
     
     <NavList />
     
     <View style={styles.pageContent}>
       <Stack.Navigator screenOptions={{ headerShown: false }}>
         
           <Stack.Screen name="Home" component={Home} />
           <Stack.Screen name="Services" component={Services} />
           <Stack.Screen name="Login" component={Login} />
           <Stack.Screen name="ServiceProducts" component={ServiceProducts} />           
           {routesFromDB
             .filter((item) => item.route && item.nav_name)
             .map((item) => {
               const screenName = item.route;
               return (
                 <Stack.Screen
                   key={screenName}
                   name={screenName}
                   component={DefaultScreen}
                   initialParams={{ title: item.nav_name }}
                 />
               );
              })}
       </Stack.Navigator>
     </View>
    </View>
   </NavigationContainer>
  );
}

//<ScrollView style={[ basicStyles.view ]}>
//</ScrollView>


const styles = StyleSheet.create({
  appContainer: {
    flex: 1
   ,flexDirection: "row"
  },

  pageContent: {
    flex: 100
   ,backgroundColor: colors[900]
   ,paddingVertical: 10
  },
});
