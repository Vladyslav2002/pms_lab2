import Foundation

// ������� 1
// ���� ����� � ������ "Student1 - Group1; Student2 - Group2; ..."
let studentsStr = "��������� ��������� - ��-84; �������� ����� - ��-83; ����� ����� - ��-82; �������� ������� - ��-83; �������� �������� - ��-83; �������� ���� - ��-83; ������ ������� - ��-81; ������� ����� - ��-83; �������� ��� - ��-82; ���������� ������ - ��-83; ������ ����� - ��-82; ̳������ ��������� - ��-83; �������� ����� - ��-82; ������ ˳�� - ��-81; �������� ���� - ��-81; ����� ��������� - ��-82; ����� ������ - ��-81; ����� ³���� - ��-81; ����� ������� - ��-83; ������ ������� - ��-81; ������ ��������� - ��-81; ��������� ͳ��� - ��-82; ���������� ������ - ��-83; ���������� ��������� - ��-82; ����� ����� - ��-81; ������ ����� - ��-83; ��������� ��� - ��-82; ����� ������� - ��-81; ������� ����� - ��-82; ������ ³���� - ��-83; ������ ������ - ��-82"

// �������� 1
// �������� �������, ��:
// - ���� � ����� �����
// - �������� � ������������ ����� ��������, �� ���������� �� �������� �����
var studentsGroups: [String: [String]] = [:]

// ��� ��� ���������� ���
var studentsList = studentsStr.split(separator: ";")
for student in studentsList {
    let currentStudent = student.trimmingCharacters(in: .whitespaces)
    let studentData = currentStudent.components(separatedBy: " - ")
    if studentsGroups.keys.contains(studentData[1]) {
        studentsGroups[studentData[1]]!.append(studentData[0])
    } else {
        studentsGroups.updateValue([studentData[0]], forKey: studentData[1])
    }
}

for group in studentsGroups.keys {
    studentsGroups[group]!.sort()
}
// ��� ��� ���������� ���
print("�������� 1")
print(studentsGroups)
print()

// ���� ����� � ����������� ��������� ��������
let points: [Int] = [12, 12, 12, 12, 12, 12, 12, 16]

// �������� 2
// �������� �������, ��:
// - ���� � ����� �����
// - �������� � �������, ��:
//   - ���� � �������, ���� ���������� �� �������� �����
//   - �������� � ����� � �������� �������� (�������� ����� ����������� ����������, �������������� ������� `randomValue(maxValue: Int) -> Int`)
func randomValue(maxValue: Int) -> Int {
    switch(arc4random_uniform(6)) {
    case 1:
        return Int(ceil(Float(maxValue) * 0.7))
    case 2:
        return Int(ceil(Float(maxValue) * 0.9))
    case 3, 4, 5:
        return maxValue
    default:
        return 0
    }
}

var studentPoints: [String: [String: [Int]]] = [:]

// ��� ��� ���������� ���
for group in studentsGroups.keys {
    for student in studentsGroups[group]! {
        let currentStudentPoints = points.map(randomValue(maxValue:))
        if studentPoints[group] == nil {
            studentPoints.updateValue([student : currentStudentPoints], forKey: group)
        } else {
            studentPoints[group]!.merge([student : currentStudentPoints], uniquingKeysWith: {
                (current, _) -> [Int] in
                current
            })
        }
    }
}


// ��� ��� ���������� ���
print("�������� 2")
print(studentPoints)
print()

// �������� 3
// �������� �������, ��:
// - ���� � ����� �����
// - �������� � �������, ��:
//   - ���� � �������, ���� ���������� �� �������� �����
//   - �������� � ���� ������ ��������
var sumPoints: [String: [String: Int]] = [:]

// ��� ��� ���������� ���
for group in studentPoints.keys {
    for student in studentPoints[group]!.keys {
        let currentStudentPointsSum = studentPoints[group]![student]?.reduce(0, +)
        if sumPoints[group] == nil {
            sumPoints.updateValue([student : currentStudentPointsSum!], forKey: group)
        } else {
            sumPoints[group]!.merge([student : currentStudentPointsSum!], uniquingKeysWith: {
                (current, _) -> Int in
                current
            })
        }
    }
}

// ��� ��� ���������� ���
print("�������� 3")
print(sumPoints)
print()

// �������� 4
// �������� �������, ��:
// - ���� � ����� �����
// - �������� � ������� ������ ��� �������� �����
var groupAvg: [String: Float] = [:]

// ��� ��� ���������� ���
for group in sumPoints.keys {
    var sum = 0
    for student in sumPoints[group]!.keys {
        sum = sum + sumPoints[group]![student]!
    }
    let currentGroupAvg = Float(sum) / Float(sumPoints[group]!.keys.count)
    groupAvg.updateValue(currentGroupAvg, forKey: group)
}

// ��� ��� ���������� ���
print("�������� 4")
print(groupAvg)
print()

// �������� 5
// �������� �������, ��:
// - ���� � ����� �����
// - �������� � ����� ��������, �� ����� >= 60 ����
var passedPerGroup: [String: [String]] = [:]

// ��� ��� ���������� ���
for group in sumPoints.keys {
    for student in sumPoints[group]!.keys {
        if sumPoints[group]![student]! >= 60 {
            if passedPerGroup.keys.contains(group){
                passedPerGroup[group]!.append(student)
            }
            else {
                passedPerGroup.updateValue([student], forKey: group)
            }
        }
    }
}

// ��� ��� ���������� ���
print("�������� 5")
print(passedPerGroup)

// ������� ���������. ��� ��������� ���� ���������� �� �������� ����� ������������ ������� random ��� ���������� ������ ������ �� ����� ���� ����� ���.
//
//�������� 1
//["��-73": ["������ ���", "��������� ���������", "������ �����", "�������� �����", "����������� ���������"], "��-72": ["������ ������", "���� ����", "�������� �����", "����� �����"], "��-71": ["���������� ������", "������� ���������", "�������� �����", "������ ���������", "������ �����", "�������� ����"]]
//
//�������� 2
//["��-73": ["��������� ���������": [5, 8, 9, 12, 11, 12, 0, 0, 14], "������ �����": [5, 8, 12, 12, 0, 12, 12, 12, 11], "�������� �����": [4, 8, 0, 12, 12, 11, 12, 12, 15], "����������� ���������": [5, 8, 12, 12, 11, 12, 12, 12, 15], "������ ���": [5, 6, 0, 12, 0, 11, 12, 11, 14]], "��-71": ["�������� �����": [0, 0, 12, 9, 11, 11, 9, 12, 15], "������ ���������": [5, 8, 12, 0, 11, 12, 0, 9, 15], "������� ���������": [5, 8, 12, 9, 12, 12, 11, 12, 15], "������ �����": [5, 0, 0, 11, 11, 0, 12, 12, 15], "���������� ������": [5, 6, 0, 12, 12, 12, 0, 9, 15], "�������� ����": [5, 8, 12, 9, 12, 9, 11, 12, 14]], "��-72": ["���� ����": [5, 8, 12, 12, 11, 12, 0, 0, 11], "�������� �����": [5, 8, 12, 0, 11, 12, 12, 12, 15], "������ ������": [4, 8, 12, 12, 0, 12, 9, 12, 15], "����� �����": [0, 8, 11, 0, 12, 12, 9, 12, 15]]]
//
//�������� 3
//["��-72": ["������ ������": 84, "����� �����": 79, "�������� �����": 87, "���� ����": 71], "��-73": ["������ �����": 84, "�������� �����": 86, "����������� ���������": 99, "������ ���": 71, "��������� ���������": 71], "��-71": ["�������� �����": 79, "������ �����": 66, "���������� ������": 71, "������� ���������": 96, "�������� ����": 92, "������ ���������": 72]]
//
//�������� 4
//["��-71": 79.333336, "��-72": 80.25, "��-73": 82.2]
//
//�������� 5
//["��-72": ["������ ������", "���� ����", "�������� �����", "����� �����"], "��-73": ["��������� ���������", "������ �����", "����������� ���������", "������ ���", "�������� �����"], "��-71": ["������ ���������", "������ �����", "������� ���������", "�������� ����", "���������� ������", "�������� �����"]]
enum Direction {
    case Latitude
    case Longitude
}
	
class CoordinateVY {
    var degree: Int
    var arcminute, arcsecond: UInt
    var dir: Direction
    
    init() {
        self.degree = 0
        self.arcminute = 0
        self.arcsecond = 0
        self.dir = .Latitude
    }
    
    init?(_ dir: Direction, _ degree: Int, _ arcminute: UInt, _ arcsecond: UInt) {
        switch dir {
        case .Latitude:
            if ((degree > 90) || (degree < -90)) {
                return nil
            }
        case .Longitude:
            if ((degree > 180) || (degree < -180)) {
                return nil
            }
        }
        
        if (arcminute > 59) {
            return nil
        }
            
        if (arcsecond > 59) {
            return nil
        }
        
        self.degree = degree
        self.arcminute = arcminute
        self.arcsecond = arcsecond
        self.dir = dir
    }
    
    func getDirLetter() -> String {
        switch self.dir {
        case .Latitude:
            if self.degree >= 0 {
                return "N"
            } else {
                return "S"
            }
        case .Longitude:
            if self.degree >= 0 {
                return "E"
            } else {
                return "W"
            }
        }
    }
    func getFirst() -> String {
        return "\(abs(self.degree))�\(self.arcminute)'\(self.arcsecond)\" \(self.getDirLetter())"
    }
    func getSecond() -> String {
        return "\(self.getDirLetter())\(Double(abs(self.degree)) + Double(self.arcminute) / 60 + Double(self.arcsecond) / 3600)�"
    }
    
    func getMedianCord(_ targetCord: CoordinateMZ) -> CoordinateMZ? {
        if (self.dir != targetCord.dir) {
            return nil
        } else {
            let selfDecimal = (self.degree > 0 ? 1 : -1) * (Double(abs(self.degree)) + Double(self.arcminute) / 60 + Double(self.arcsecond) / 3600)
            let targetDecimal = (targetCord.degree > 0 ? 1 : -1) * (Double(abs(targetCord.degree)) + Double(targetCord.arcminute) / 60 + Double(targetCord.arcsecond) / 3600)
            let resultingDecimal = (selfDecimal + targetDecimal) / 2
            let resultingArcminute = (abs(resultingDecimal) - Double(Int(abs(resultingDecimal)))) * 60
            let resultingArcsecond = (resultingArcminute - Double(Int(resultingArcminute))) * 60
            return CoordinateMZ(self.dir, Int(resultingDecimal), UInt(resultingArcminute), UInt(resultingArcsecond))
        }
    }
    
    static func getMedianBetweenTwo(_ cord1: CoordinateMZ, _ cord2: CoordinateMZ) -> CoordinateMZ? {
        if (cord1.dir != cord2.dir) {
            return nil
        } else {
            let firstDecimal = (cord1.degree > 0 ? 1 : -1) * (Double(abs(cord1.degree)) + Double(cord1.arcminute) / 60 + Double(cord1.arcsecond) / 3600)
            let secondDecimal = (cord2.degree > 0 ? 1 : -1) * (Double(abs(cord2.degree)) + Double(cord2.arcminute) / 60 + Double(cord2.arcsecond) / 3600)
            let resultingDecimal = (firstDecimal + secondDecimal) / 2
            let resultingArcminute = (abs(resultingDecimal) - Double(Int(abs(resultingDecimal)))) * 60
            let resultingArcsecond = (resultingArcminute - Double(Int(resultingArcminute))) * 60
            return CoordinateMZ(cord1.dir, Int(resultingDecimal), UInt(resultingArcminute), UInt(resultingArcsecond))
        }
    }
}

print()
print("������ 2:")

print("������� 1")
if let cord1 = CoordinateVY(.Latitude, -30, 30, 3), let cord2 = CoordinateVY(.Latitude, 70, 20, 2){
    print("cord1:")
    print(cord1.getFirst())
    print(cord1.getSecond())
    print("cord2")
    print(cord2.getFirst())
    print(cord2.getSecond())
    
    if let medianCord1 = cord1.getMedianCord(cord2), let medianCord2 = CoordinateVY.getMedianBetweenTwo(cord1, cord2){
        print("median1")
        print(medianCord1.getFirst())
        print(medianCord1.getSecond())
        print("median2")
        print(medianCord2.getFirst())
        print(medianCord2.getSecond())
    } else {
        print("������� 1, ������� �������")
    }
} else {
    print("������� 1, ������� �������")
}

print()
print("������� 2")
if let cord1 = CoordinateVY(.Longitude, -15, 27, 32), let cord2 = CoordinateVY(.Longitude, 150, 1, 23){
    print("cord1:")
    print(cord1.getFirst())
    print(cord1.getSecond())
    print("cord2")
    print(cord2.getFirst())
    print(cord2.getSecond())
    
    if let medianCord1 = cord1.getMedianCord(cord2), let medianCord2 = CoordinateVY.getMedianBetweenTwo(cord1, cord2){
        print("median1")
        print(medianCord1.getFirst())
        print(medianCord1.getSecond())
        print("median2")
        print(medianCord2.getFirst())
        print(medianCord2.getSecond())
    } else {
        print("������� 2, ������� �������")
    }
} else {
    print("������� 2, ������� �������")
}

print()
print("������� 3")
if let cord1 = CoordinateVY(.Longitude, -300, 30, 3), let cord2 = CoordinateVY(.Latitude, 70, 20, 2){
    print("cord1:")
    print(cord1.getFirst())
    print(cord1.getSecond())
    print("cord2")
    print(cord2.getFirst())
    print(cord2.getSecond())
} else {
    print("������� 3, ������� �������")
}

print()
print("������� 4")
if let cord1 = CoordinateVY(.Longitude, -30, 30, 3), let cord2 = CoordinateVY(.Latitude, 70, 20, 2){
    print("cord1:")
    print(cord1.getFirst())
    print(cord1.getSecond())
    print("cord2")
    print(cord2.getFirst())
    print(cord2.getSecond())
    
    if let medianCord1 = cord1.getMedianCord(cord2), let medianCord2 = CoordinateVY.getMedianBetweenTwo(cord1, cord2){
        print("median1")
        print(medianCord1.getFirst())
        print(medianCord1.getSecond())
        print("median2")
        print(medianCord2.getFirst())
        print(medianCord2.getSecond())
    } else {
        print("������� 4, ������� �������")
    }
} else {
    print("������� 4, ������� �������")
}