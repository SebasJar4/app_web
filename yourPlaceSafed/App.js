import React, { useEffect, useState } from "react";
import { NavigationContainer } from "@react-navigation/native";
import { createNativeStackNavigator } from "@react-navigation/native-stack";
import { View, StyleSheet } from "react-native";
import NavList from "./screens/NavList";
import { getNavs } from "./services/getNav";
// Pantallas base
import Home from "./screens/Home";
import Services from "./screens/Services";
import Login from "./screens/Login";
import Default from "./screens/Default";


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

const styles = StyleSheet.create({
  appContainer: {
    flex: 1
   ,flexDirection: "row"
  },
  pageContent: {
    flex: 1
  },
});
