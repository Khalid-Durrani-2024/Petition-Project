<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include_once '../config/database.php';//importing previous files into this one file
include_once '../models/admin.php';

$database = new Database();
$db = $database->getConnection();

$admin = new Admin($db);

$request_method = $_SERVER["REQUEST_METHOD"];

switch($request_method) {
    case 'GET':
        $stmt = $admin->read();
        $num = $stmt->rowCount();

        if($num > 0) {
            $admin_arr = array();
            $admin_arr["records"] = array();

            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                extract($row);

                $admin_item = array(
                    "id" => $id,
                    "name" => $name,
                    "email" => $email,
                    "password" => $password,
                    "role" => $role
                );

                array_push($admin_arr["records"], $admin_item);
            }

            http_response_code(200);
            echo json_encode($admin_arr);
        } else {
            http_response_code(404);
            echo json_encode(array("message" => "No admins found."));
        }
        break;

    case 'POST':
        $data = json_decode(file_get_contents("php://input"));

        if (
            !empty($data->name) &&
            !empty($data->email) &&
            !empty($data->password) &&
            !empty($data->role)
        ) {
            $admin->name = $data->name;
            $admin->email = $data->email;
            $admin->password = $data->password;
            $admin->role = $data->role;

            if ($admin->create()) {
                http_response_code(201);
                echo json_encode(array("message" => "Admin was created."));
            } else {
                http_response_code(503);
                echo json_encode(array("message" => "Unable to create admin."));
            }
        } else {
            http_response_code(400);
            echo json_encode(array("message" => "Unable to create admin. Data is incomplete."));
        }
        break;

    case 'PUT':
        $data = json_decode(file_get_contents("php://input"));

        $admin->id = $data->id;

        if (
            !empty($data->name) &&
            !empty($data->email) &&
            !empty($data->password) &&
            !empty($data->role)
        ) {
            $admin->name = $data->name;
            $admin->email = $data->email;
            $admin->password = $data->password;
            $admin->role = $data->role;

            if ($admin->update()) {
                http_response_code(200);
                echo json_encode(array("message" => "Admin was updated."));
            } else {
                http_response_code(503);
                echo json_encode(array("message" => "Unable to update admin."));
            }
        } else {
            http_response_code(400);
            echo json_encode(array("message" => "Unable to update admin. Data is incomplete."));
        }
        break;

    case 'DELETE':
        $data = json_decode(file_get_contents("php://input"));

        $admin->id = $data->id;

        if ($admin->delete()) {
            http_response_code(200);
            echo json_encode(array("message" => "Admin was deleted."));
        } else {
            http_response_code(503);
            echo json_encode(array("message" => "Unable to delete admin."));
        }
        break;

    default:
        http_response_code(405);
        echo json_encode(array("message" => "Method not allowed."));
        break;
}
?>
