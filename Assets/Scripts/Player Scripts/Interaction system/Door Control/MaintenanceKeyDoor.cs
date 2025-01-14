using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class MaintenanceKeyDoor : MonoBehaviour
{
    public InventorySpace Items;

    // Smoothly open a door
    public AnimationCurve openSpeedCurve = new AnimationCurve(new Keyframe[] { new Keyframe(0, 1, 0, 0), new Keyframe(0.8f, 1, 0, 0), new Keyframe(1, 0, 0, 0) });
    public float openSpeedMultiplier = 2.0f;
    public float doorOpenAngle = 90.0f;

    bool open = false;
    bool enter = false;

    float defaultRotationAngle;
    float currentRotationAngle;
    float openTime = 0;

    [SerializeField] Image interactionPopup;
    [SerializeField] Image noKeyText;
    public AudioSource doorCreak;

    void Start()
    {
        defaultRotationAngle = transform.localEulerAngles.y;
        currentRotationAngle = transform.localEulerAngles.y;

        //Set Collider as trigger
        GetComponent<Collider>().isTrigger = true;
    }

    void Update()
    {
        foreach (Item i in Items.items)
        {
            if (i.id == 15)
            {
                if (openTime < 1)
                {
                    openTime += Time.deltaTime * openSpeedMultiplier * openSpeedCurve.Evaluate(openTime);
                }
                transform.localEulerAngles = new Vector3(transform.localEulerAngles.x, Mathf.LerpAngle(currentRotationAngle, defaultRotationAngle + (open ? doorOpenAngle : 0), openTime), transform.localEulerAngles.z);

                if (Input.GetKeyDown(KeyCode.E) && enter)
                {
                    OpenDoor();
                }
            }
        }
    }

    void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            enter = true;
            interactionPopup.gameObject.SetActive(true);
            
            //Pulls up Missing Key Text
            foreach(Item i in Items.items)
            {
                if(!open && i.id != 15)
                {
                    noKeyText.gameObject.SetActive(true);
                }
            }

            if (Items.items.Count < 1)
            {
                noKeyText.gameObject.SetActive(true);
            }
        }
    }

    void OnTriggerExit(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            enter = false;
            interactionPopup.gameObject.SetActive(false);

            //If active, closes it
            noKeyText.gameObject.SetActive(false);
        }
    }

    public void OpenDoor()
    {
        open = !open;
        currentRotationAngle = transform.localEulerAngles.y;
        openTime = 0;
        doorCreak.Play();
    }
}
