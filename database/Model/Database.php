<?php
class Database{
  public static $connection = NULL;

  //1.Tạo kết nối
  public function __construct()
  {
    if (self::$connection == NULL) {
      self::$connection = new mysqli(DB_HOST,DB_USER,DB_PASS,DB_NAME);
      self::$connection->set_charset('utf8mb4');
    }
  }
  //Thực thi câu lệnh
  public function select($sql){
    $item = [];
    // Thực thi câu sql
    $sql->excute();
    //Xử lí kết quả
    $item = $sql->get_result()->fetch_all(MYSQLI_ASSOC);
    return $item;
  }
}