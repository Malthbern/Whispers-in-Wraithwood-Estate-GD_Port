using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

[CreateAssetMenu(fileName = "New Item", menuName = "Item/Create New Item")]

public class Item : ScriptableObject
{
    public int id;
    public string itemName;
    public string itemDescription;
    public Sprite icon;
    public Texture2D ItemInspectionImage;
    public Transform prefab;
}
