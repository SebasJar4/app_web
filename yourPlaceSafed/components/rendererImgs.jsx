import { SvgUri } from "react-native-svg"
import { View , Text , Image } from "react-native";

const handleError = ( error ) => {
  console.error( error );
  return (
    <View style={{
    backgroundColor:" #fff "
    ,display:"flex"
    ,justifyContent:"center"
    ,alignItems:"center" }} >

    <Text style={{color:"#f00"}}>
      { "!!Error en el SvgUri:    " + error } 
    </Text>
    </View>
  )
}

const getSvg = ( id , url ) => {
  let respose;
  try {
    respose = (
      <SvgUri 
        key={ id }
        uri={ url } 
        width={ 100 }
        height={ 100 }
      />
    )
  } catch (error) {
      respose = handleError( error );
  } finally {
    return respose;
  }
} 

const getImg = ( id , url ) => {
  let respose;
  try {
    respose = (
      <Image 
        key={ id }
        source={ { uri: url } } 
        width={ 100 }
        height={ 100 }
      />
    )
  } catch (error) {
      respose = handleError( error );
  } finally {
    return respose;
  }
}


export default rendererImgs = ( img ) => // Argumentos de entrada{ id , url  isSvg }
  img.map(  e => e.isSvg ? getSvg( {id: e.id ,url: url}) : getImg( id , url ) );