<?php
class Signatures {
    private $conn;
    private $table_name = "signatures";

    public $id;
    public $user_id;
    public $signed_at;
   
    public $petition_id;

    public function __construct($db) {//constructor
        $this->conn = $db;
    }

    public function read() {
        $query = "SELECT * FROM " . $this->table_name;
        $stmt = $this->conn->prepare($query);
        $stmt->execute();

        return $stmt;
    }

    public function create() { //Signing petition
        $query = "INSERT INTO " . $this->table_name . " SET user_id=:user_id, signed_at=:signed_at, petition_id=:petition_id";
        $stmt = $this->conn->prepare($query);


        $this->user_id = htmlspecialchars(strip_tags($this->user_id));
        $this->signed_at = htmlspecialchars(strip_tags($this->signed_at));
        $this->petition_id = htmlspecialchars(strip_tags($this->petition_id));

        $stmt->bindParam(":user_id", $this->user_id);
        $stmt->bindParam(":signed_at", $this->signed_at);
        $stmt->bindParam(":petition_id", $this->petition_id);

        if($stmt->execute()) {
            return true;
        }

        return false;
    }

    public function update() {//updating Sign in database 
        $query = "UPDATE " . $this->table_name . " SET user_id = :user_id, signed_at = :signed_at, petition_id = :petition_id WHERE id = :id";
        $stmt = $this->conn->prepare($query);

        $this->user_id = htmlspecialchars(strip_tags($this->user_id));
        $this->signed_at = htmlspecialchars(strip_tags($this->signed_at));
        $this->petition_id = htmlspecialchars(strip_tags($this->petition_id));
        $this->id = htmlspecialchars(strip_tags($this->id));

        $stmt->bindParam(':user_id', $this->user_id);
        $stmt->bindParam(':signed_at', $this->signed_at);
        $stmt->bindParam(':petition_id', $this->petition_id);
        $stmt->bindParam(':id', $this->id);

        if ($stmt->execute()) {
            return true;
        }

        return false;
    }

    public function delete() { //deleting the sign from database
        $query = "DELETE FROM " . $this->table_name . " WHERE id = :id";
        $stmt = $this->conn->prepare($query);

        $this->id = htmlspecialchars(strip_tags($this->id));
        $stmt->bindParam(':id', $this->id);

        if ($stmt->execute()) {
            return true;
        }

        return false;
    }
}
?>
