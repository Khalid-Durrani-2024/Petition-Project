<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST, GET, PUT, DELETE");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include_once '../config/database.php';//importing previous files into this one file
include_once '../models/users.php';

$database = new Database();
$db = $database->getConnection();

$users = new users($db);

$request_method = $_SERVER["REQUEST_METHOD"];

switch($request_method) {
    case 'GET':
        $stmt = $users->read();
        $num = $stmt->rowCount();

        if($num > 0) {
            $users_arr = array();
            $users_arr["records"] = array();

            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                extract($row);

                $users_item = array(
                    "id" => $id,
                    "name" => $name,
                    "email"=>$email,
                    "password" => $password,
                    "university_id" => $university_id,
                    "created_at"=>$created_at,
                    "role" => $role,
                
                );

                array_push($users_arr["records"], $users_item);
            }

            http_response_code(200);
            echo json_encode($users_arr);
        } else {
            http_response_code(404);
            echo json_encode(array("message" => "No User found for university."));
        }
        break;

    case 'POST':
        $data = json_decode(file_get_contents("php://input"));

        if (
            !empty($data->name) &&
            !empty($data->email) &&
            !empty($data->password) &&
            !empty($data->university_id) &&
            !empty($data->created_at) &&
            
            !empty($data->role)
            
        ) {
            $users->name = $data->name;
            $users->email = $data->email;
           
            $users->password = $data->password;
            $users->university_id = $data->university_id;
            $users->created_at = $data->created_at;
            
            $users->role = $data->role;
       
            if ($users->create()) {
                http_response_code(201);
                echo json_encode(array("message" => "user has been added in Database."));
            } else {
                http_response_code(503);
                echo json_encode(array("message" => "Unable to create user."));
            }
        } else {
            http_response_code(400);
            echo json_encode(array("message" => "Unable to create user. Data is not complete."));
        }
        break;

    case 'PUT':
        $data = json_decode(file_get_contents("php://input"));

        $users->id = $data->id;

        if (
            !empty($data->name) &&
            !empty($data->email) &&
           
            !empty($data->password) &&
            !empty($data->university_id) &&
            !empty($data->created_at) &&
           
            !empty($data->role)
            
        ) {
            $users->name = $data->name;
            $users->email = $data->email;
           
            $users->password = $data->password;
            $users->university_id = $data->university_id;
            $users->created_at = $data->created_at;
           
            $users->role = $data->role;
    
            if ($users->update()) {
                http_response_code(200);
                echo json_encode(array("message" => "User has been updated."));
            } else {
                http_response_code(503);
                echo json_encode(array("message" => "Unable to update User."));
            }
        } else {
            http_response_code(400);
            echo json_encode(array("message" => "Unable to update User. Data is incomplete."));
        }
        break;

    case 'DELETE':
        $data = json_decode(file_get_contents("php://input"));

        $users->id = $data->id;

        if ($users->delete()) {
            http_response_code(200);
            echo json_encode(array("message" => "User is deleted successfully."));
        } else {
            http_response_code(503);
            echo json_encode(array("message" => "Unable to delete User some error occured."));
        }
        break;

    default:
        http_response_code(405);
        echo json_encode(array("message" => "Method not allowed."));
        break;
}
?>
