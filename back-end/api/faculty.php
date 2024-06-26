<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST, GET, PUT, DELETE");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include_once '../config/database.php';//importing previous files into this one file
include_once '../models/faculty.php';

$database = new Database();
$db = $database->getConnection();

$faculty = new faculty($db);

$request_method = $_SERVER["REQUEST_METHOD"];

switch($request_method) {
    case 'GET':
        $stmt = $faculty->read();
        $num = $stmt->rowCount();

        if($num > 0) {
            $faculty_arr = array();
            $faculty_arr["records"] = array();

            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                extract($row);

                $faculty_item = array(
                    "id" => $id,
                    "name" => $name,
                    "university_id"=>$university_id,
                    "email" => $email,
                    "password" => $password,
                    "university_name"=>$university_name,
                    "role" => $role
                );

                array_push($faculty_arr["records"], $faculty_item);
            }

            http_response_code(200);
            echo json_encode($faculty_arr);
        } else {
            http_response_code(404);
            echo json_encode(array("message" => "No Faculty found."));
        }
        break;

    case 'POST':
        $data = json_decode(file_get_contents("php://input"));

        if (
            !empty($data->name) &&
            !empty($data->university_id) &&
            !empty($data->email) &&
            !empty($data->password) &&
            !empty($data->university_name) &&
            
            !empty($data->role)
        ) {
            $faculty->name = $data->name;
            $faculty->university_id = $data->university_id;
           
            $faculty->email = $data->email;
            $faculty->password = $data->password;
            $faculty->university_name = $data->university_name;
            
            $faculty->role = $data->role;

            if ($faculty->create()) {
                http_response_code(201);
                echo json_encode(array("message" => "Faculty has been created."));
            } else {
                http_response_code(503);
                echo json_encode(array("message" => "Unable to create Faculty in Database."));
            }
        } else {
            http_response_code(400);
            echo json_encode(array("message" => "Unable to create Faculty. Data is incomplete."));
        }
        break;

    case 'PUT':
        $data = json_decode(file_get_contents("php://input"));

        $faculty->id = $data->id;

        if (
            !empty($data->name) &&
            !empty($data->university_id) &&
           
            !empty($data->email) &&
            !empty($data->password) &&
            !empty($data->university_name) &&
           
            !empty($data->role)
        ) {
            $faculty->name = $data->name;
            $faculty->name = $data->university_id;
           
            $faculty->email = $data->email;
            $faculty->password = $data->password;
            $faculty->name = $data->university_name;
           
            $faculty->role = $data->role;

            if ($faculty->update()) {
                http_response_code(200);
                echo json_encode(array("message" => "Faculty has been updated."));
            } else {
                http_response_code(503);
                echo json_encode(array("message" => "Unable to update Faculty."));
            }
        } else {
            http_response_code(400);
            echo json_encode(array("message" => "Unable to update faculty. Data is incomplete."));
        }
        break;

    case 'DELETE':
        $data = json_decode(file_get_contents("php://input"));

        $faculty->id = $data->id;

        if ($faculty->delete()) {
            http_response_code(200);
            echo json_encode(array("message" => "Faculty was deleted."));
        } else {
            http_response_code(503);
            echo json_encode(array("message" => "Unable to delete faculty."));
        }
        break;

    default:
        http_response_code(405);
        echo json_encode(array("message" => "Method not allowed."));
        break;
}
?>
