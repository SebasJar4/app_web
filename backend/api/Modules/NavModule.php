<?php

namespace Modules;

class NavModule extends BaseModule
{
    public function getNav() : array {
        $query = "CALL get_nav_active_with_imgs();";
        $datos = $this->getAllRows( $query );
        return $datos;
    }

}
?>