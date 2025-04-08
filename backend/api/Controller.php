<?php
require_once("connect.php");

abstract class Controller 
{
  private $con;
  private $db;

  public function __construct() {
    $this->db = new DB();
    $this->con = $this->db->getConnection();
  }

  public function clone(){
    $this->db->close();
  }
}
