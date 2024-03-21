<?php 
class User extends Database{
  //Lấy tất cả user
  public function getAllProducts(){
    $sql = parent::$connection->prepare('SELECT * FROM `users` ORDER BY `id` DESC ' );
    return parent::select($sql);
}  
}