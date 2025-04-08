import React, { useEffect, useState } from "react";
import { View, Text, FlatList, StyleSheet } from "react-native";
import { getNavs } from "../services/navService";

export default function NavList() {
  const [navs, setNavs] = useState([]);

  useEffect(() => {
    (async () => {
      const data = await getNavs();
      setNavs(data);
    })();
  }, []);

  return (
    <View style={styles.container}>
      <FlatList
        data={navs}
        keyExtractor={(item) => item.nav_id.toString()}
        renderItem={({ item }) => (
          <View style={styles.item}>
            <Text style={styles.title}>{item.nav_name}</Text>
            <Text>{item.nav_description}</Text>
            <Text style={styles.url}>{item.url}</Text>
          </View>
        )}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: { padding: 16 },
  item: { marginBottom: 16, padding: 12, backgroundColor: "#f0f0f0", borderRadius: 10 },
  title: { fontWeight: "bold", fontSize: 18 },
  url: { color: "blue" },
});
