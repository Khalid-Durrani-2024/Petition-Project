<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json; charset=UTF-8");

include_once '../config/database.php'; // importing previous file of Database connectivity into this one file
include_once '../models/send_from_faculty.php';

$database = new Database();
$db = $database->getConnection();

$send_from_faculty = new send_from_faculty($db);

$request_method = $_SERVER["REQUEST_METHOD"];

switch($request_method) {
    case 'GET':
        try {
            $stmt = $send_from_faculty->read();
            $num = $stmt->rowCount();
            if ($num > 0) {
                $send_from_faculty_arr = array();
                $send_from_faculty_arr["records"] = array();

                while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                    extract($row);
                    $send_from_faculty_item = array(
                        "id" => $id,
                        "petition_id" => $petition_id,
                        "university_id" => $university_id,
                        "comment" => $comment,
                        "faculty_id" => $faculty_id

                    );
                    array_push($send_from_faculty_arr["records"], $send_from_faculty_item);
                }
                http_response_code(200);
                echo json_encode($send_from_faculty_arr);
            } else {
                http_response_code(404);
                echo json_encode(array("message" => "No petition found."));
            }
        } catch (Exception $e) {
            http_response_code(503);
            echo json_encode(array("message" => "Service unavailable. Error: " . $e->getMessage()));
        }
        break;

    case 'POST':
        $data = json_decode(file_get_contents("php://input"));

        if (!empty($data->university_id) && !empty($data->faculty_id) && !empty($data->comment)) {
            $send_from_faculty->petition_id = $data->petition_id;
            $send_from_faculty->university_id = $data->university_id;
            $send_from_faculty->comment = $data->comment;
            $send_from_faculty->faculty_id = $data->faculty_id;
          

            try {
                if ($send_from_faculty->create()) {
                    http_response_code(201);
                    echo json_encode(array("message" => "Petition sent to faculty in Database."));
                } else {
                    http_response_code(503);
                    echo json_encode(array("message" => "Unable to add petition to faculty."));
                    error_log("Create Error: " . json_encode($stmt->errorInfo()));
                }
            } catch (Exception $e) {
                http_response_code(503);
                echo json_encode(array("message" => "Service unavailable. Error: " . $e->getMessage()));
                error_log("Exception: " . $e->getMessage());
            }
        } else {
            http_response_code(400);
            echo json_encode(array("message" => "Unable to add petition for faculty in database. Data is incomplete."));
        }
        break;

    case 'PUT':
        $data = json_decode(file_get_contents("php://input"));

        $send_from_faculty->id = $data->id;

        if (!empty($data->university_id) && !empty($data->faculty_id) && !empty($data->comment)) {
            $send_from_faculty->petition_id = $data->petition_id;
            $send_from_faculty->university_id = $data->university_id;
            $send_from_faculty->comment = $data->comment;
            $send_from_faculty->faculty_id = $data->faculty_id;

            try {
                if ($send_from_faculty->update()) {
                    http_response_code(200);
                    echo json_encode(array("message" => "Petition in faculty has been updated."));
                } else {
                    http_response_code(503);
                    echo json_encode(array("message" => "Unable to update petition for faculty."));
                    error_log("Update Error: " . json_encode($stmt->errorInfo()));
                }
            } catch (Exception $e) {
                http_response_code(503);
                echo json_encode(array("message" => "Service unavailable. Error: " . $e->getMessage()));
                error_log("Exception: " . $e->getMessage());
            }
        } else {
            http_response_code(400);
            echo json_encode(array("message" => "Unable to update petition in faculty. Data is incomplete."));
        }
        break;

    case 'DELETE':
        $data = json_decode(file_get_contents("php://input"));
        error_log("Delete Data: " . json_encode($data));
        $send_from_faculty->id = $data->id;

        try {
            if ($send_from_faculty->delete()) {
                http_response_code(200);
                echo json_encode(array("message" => "Faculty petition has been deleted."));
            } else {
                http_response_code(503);
                echo json_encode(array("message" => "Unable to delete petition for faculty."));
                error_log("Delete Error: " . json_encode($stmt->errorInfo()));
            }
        } catch (Exception $e) {
            http_response_code(503);
            echo json_encode(array("message" => "Service unavailable. Error: " . $e->getMessage()));
            error_log("Exception: " . $e->getMessage());
        }
        break;

    default:
        http_response_code(405);
        echo json_encode(array("message" => "Method not allowed."));
        break;
}
?>
